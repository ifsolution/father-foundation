Pod::Spec.new do |s|
  s.name = "DadFoundation"
  s.version = "0.1.2"
  s.summary = "The definitions and protocols for module basic and integration"

  s.description = <<-DESC
TODO: Add long description of the pod here.
                  DESC

  s.homepage = "https://github.com/ifsolution/DadFoundation"
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "NGUYEN CHI CONG" => "congnc.if@gmail.com" }
  s.source = { :git => "git@github.com:ifsolution/father-foundation.git", :tag => s.version.to_s }
  s.social_media_url = "https://twitter.com/congncif"

  s.ios.deployment_target = "10.0"
  s.swift_versions = ["5.0", "5.1", "5.2", "5.3", "5.4"]

  s.source_files = "DadFoundation/Classes/**/*"

  s.dependency "Boardy"
end
