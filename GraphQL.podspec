Pod::Spec.new do |s|

  s.name                  = "GraphQL"
  s.version               = "0.0.3"
  s.summary               = "Library for creating GraphQL schemas and executing queries in Objective-C."

  s.description           = <<-DESC
                            Use the Javascript reference implementation from Facebook to create GraphQL
                            schemas and execute queries in Objective-C.
                            DESC

  s.homepage              = "https://github.com/tlil/graphql-objc"
  s.license               = "BSD"

  s.author                = { "Tommy Lillehagen" => "tommy@lillehagen.me" }

  s.platform              = :ios, "6.0"
  s.platform              = :osx, "10.7"

  s.ios.deployment_target = "6.0"
  s.osx.deployment_target = "10.7"

  s.source                = { :git => "https://github.com/tlil/graphql-objc.git", :tag => "#{s.version}" }

  s.source_files          = "Classes", "GraphQL/Classes/**/*.{h,m}"
  s.exclude_files         = "Classes/Exclude"

  s.framework             = "JavaScriptCore"

  s.subspec 'Resources' do |resources|
    resources.resource_bundle = {'Scripts' => ['Engine/engine.js']}
  end

end
