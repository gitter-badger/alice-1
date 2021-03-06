class DetectedComponent < ActiveRecord::Base
  belongs_to :detection
  attr_accessible :component_id, :license_id, :license_name, :license_version, :name, :version, :own, :purchased
  
  validates_presence_of :name, :version

  @@grubber = ["license","public","software","none","and","the",'^no ', " no ","information","available", '\.']
  
  after_update do
    # Se il componente è presente in più rilevamenti della release, aggiorna i dati su tutti
    same_release_detections = self.detection.release.detections
    same_release_detections.each do |same_release_detection|
      same_components = same_release_detection.detected_components.where(name: self.name, license_id: nil)
      same_components.each do |same_component|
        same_component.license_id = self.license_id
        same_component.purchased = self.purchased
        same_component.own= self.own
        same_component.save
      end
    end
  end
  
  def purify_name(name)
    purified_name = String.new(str=name)
    @@grubber.each do |dirty|
      purified_name.gsub!(/#{dirty}/i,'')
    end
    return purified_name.strip
  end
  
  def search_licenses(name, version)
    return License.all if name.nil?
    words = purify_name(name).split
    return License.all if words.length == 0

    queryString = "("
    words.each do |word|
      queryString << "description LIKE '%#{word}%' or "
    end 
    queryString = queryString[0..-5] + ')'
    if version != nil
      queryString << " and version LIKE '%#{version}%'"
    end
    if License.where(queryString).count > 0
      return License.where(queryString).order("description")
    else
      return License.order("description")
    end
  end
 
end
