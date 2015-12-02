#
# Be sure to run `pod lib lint KMDDeDupeDictionaries.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "KMDDeDupeDictionaries"
  s.version          = "0.1.0"
  s.summary          = "iOS Library to track if dictionaries are duplicated within a timeout."
  s.description      = <<-DESC
                        iOS Library to track if dictionaries are duplicated within a given timeout period. This can be useful for example in discarding duplicate remote notifications by examining the dictionaries sent from the server.

                        This libary supports overriding the default storage type (PList) with custom storage such as SQLLite or NSUserDefaults. Simply conform to KMDDDStorageType and set StorageType to be custom on the manager.
                       DESC

  s.homepage         = "https://github.com/KomodoHQ/KMDDeDupeDictionaries"
  s.license          = 'MIT'
  s.author           = { "Ian Outterside" => "ian@komododigital.co.uk" }
  s.source           = { :git => "https://github.com/KomodoHQ/KMDDeDupeDictionaries.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'KMDDeDupeDictionaries' => ['Pod/Assets/*.png']
  }
end