Pod::Spec.new do |s|
  s.name        = "SimpleMQTTClient"
  s.version     = "0.0.1"
  s.summary     = "SimpleMQTTClient makes it easy to deal with MQTT in Swift"
  s.homepage    = "https://github.com/aperritano/simple-swift-mqtt-client.git"
  s.license     = { :type => "MIT" }
  s.authors     = { "aperritano" => "aperritano@gmail.com" }

  s.requires_arc = true

  s.ios.deployment_target = "9.3"

  s.source   = { :git => "https://github.com/aperritano/simple-swift-mqtt-client.git", :tag => s.version }
  s.source_files = 'simple-swift-mqtt-client/Classes/**/*'
  s.resource_bundles = {
    'simple-swift-mqtt-client' => ['simple-swift-mqtt-client/Assets/*.png']
  }
end