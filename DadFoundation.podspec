Pod::Spec.new do |s|
  s.name = "DadFoundation"
  s.version = "1.0.0"
  s.summary = "The definitions and protocols for module basic and integration"

  s.description = <<-DESC
TODO: Add long description of the pod here.
                  DESC

  s.homepage = "https://github.com/ifsolution/father-foundation"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "NGUYEN CHI CONG" => "congnc.if@gmail.com" }
  s.source = { :git => "https://github.com/ifsolution/father-foundation.git", :tag => s.version.to_s }
  s.social_media_url = "https://twitter.com/congncif"

  s.ios.deployment_target = "10.0"
  s.swift_versions = ["5.3", "5.4"]

  s.source_files = "DadFoundation/Classes/**/*"

  s.dependency "Boardy"
end
