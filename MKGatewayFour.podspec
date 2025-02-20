#
# Be sure to run `pod lib lint MKGatewayFour.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKGatewayFour'
  s.version          = '0.0.2'
  s.summary          = 'A short description of MKGatewayFour.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lovexiaoxia/MKGatewayFour'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lovexiaoxia' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/lovexiaoxia/MKGatewayFour.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.0'
  
  s.resource_bundles = {
    'MKGatewayFour' => ['MKGatewayFour/Assets/*.png']
  }

  s.subspec 'CTMediator' do |ss|
    ss.source_files = 'MKGatewayFour/Classes/CTMediator/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'CTMediator'
  end
  
  s.subspec 'DatabaseManager' do |ss|
    ss.subspec 'LogDatabase' do |sss|
      sss.source_files = 'MKGatewayFour/Classes/DatabaseManager/LogDatabase/**'
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'FMDB'
  end
  
  s.subspec 'SDK' do |ss|
    ss.source_files = 'MKGatewayFour/Classes/SDK/**'
    
    ss.dependency 'MKBaseBleModule'
  end
  
  s.subspec 'Target' do |ss|
    ss.source_files = 'MKGatewayFour/Classes/Target/**'
    
    ss.dependency 'MKGatewayFour/Functions'
  end
  
  s.subspec 'ConnectModule' do |ss|
    ss.source_files = 'MKGatewayFour/Classes/ConnectModule/**'
    
    ss.dependency 'MKGatewayFour/SDK'
    
    ss.dependency 'MKBaseModuleLibrary'
  end
  
  s.subspec 'Expand' do |ss|
    
    ss.subspec 'ExcelManager' do |sss|
      
      sss.source_files = 'MKGatewayFour/Classes/Expand/ExcelManager/**'
          
      sss.dependency 'libxlsxwriter'
      sss.dependency 'SSZipArchive'
    end
    
    ss.subspec 'ImportServerPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Expand/ImportServerPage/Controller/**'
      end
    end
    
    ss.subspec 'View' do |sss|
      sss.subspec 'ButtonListCell' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Expand/View/ButtonListCell/**'
      end
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
  end
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'AxisSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/AxisSettingsPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/AxisSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/AxisSettingsPage/Model/**'
      end
    end
    
    ss.subspec 'BatteryManagementPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/BatteryManagementPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/BatteryManagementPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/BatteryManagementPage/Model/**'
      end
    end
    
    ss.subspec 'BleParamsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/BleParamsPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/BleParamsPage/Model'
        ssss.dependency 'MKGatewayFour/Functions/BleParamsPage/View'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/BleParamsPage/Model/**'
      end
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/BleParamsPage/View/**'
      end
    end
    
    ss.subspec 'DebuggerPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/DebuggerPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/DebuggerPage/View'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/DebuggerPage/View/**'
      end
    end
    
    ss.subspec 'DeviceInfoPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/DeviceInfoPage/Controller/**'
      
        ssss.dependency 'MKGatewayFour/Functions/DeviceInfoPage/Model'
      
        ssss.dependency 'MKGatewayFour/Functions/UpdatePage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/DeviceInfoPage/Model/**'
      end
    end
    
    ss.subspec 'FilterPages' do |sss|
      
      sss.subspec 'FilterByAdvNamePage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByAdvNamePage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByAdvNamePage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByAdvNamePage/Model/**'
        end
      end
      
      sss.subspec 'FilterByBeaconPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByBeaconPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByBeaconPage/Header'
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByBeaconPage/Model'
          
        end
        
        ssss.subspec 'Header' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByBeaconPage/Header/**'
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByBeaconPage/Model/**'
          
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByBeaconPage/Header'
        end
      end
      
      sss.subspec 'FilterByBXPButtonPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByBXPButtonPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByBXPButtonPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByBXPButtonPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByBXPSPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByBXPSPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByBXPSPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByBXPSPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByBXPTagPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByBXPTagPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByBXPTagPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByBXPTagPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByMacPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByMacPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByMacPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByMacPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByOtherPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByOtherPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByOtherPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByOtherPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByPirPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByPirPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByPirPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByPirPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByRawDataPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByRawDataPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByRawDataPage/Model'
          
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByBeaconPage/Controller'
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByUIDPage/Controller'
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByURLPage/Controller'
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByTLMPage/Controller'
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByBXPButtonPage/Controller'
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByBXPTagPage/Controller'
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByPirPage/Controller'
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByTofPage/Controller'
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByOtherPage/Controller'
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByBXPSPage/Controller'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByRawDataPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByTLMPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByTLMPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByTLMPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByTLMPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByTofPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByTofPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByTofPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByTofPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByUIDPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByUIDPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByUIDPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByUIDPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByURLPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByURLPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/FilterPages/FilterByURLPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/FilterPages/FilterByURLPage/Model/**'
        end
      end
      
    end
    
    ss.subspec 'FilterSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/FilterSettingsPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/FilterSettingsPage/Model'
        
        ssss.dependency 'MKGatewayFour/Functions/FilterPages'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/FilterSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'FixModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/FixModePage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/FixModePage/Model'
        
        ssss.dependency 'MKGatewayFour/Functions/PeriodicFixPage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/MotionFixPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/FixModePage/Model/**'
      end
      
    end
    
    ss.subspec 'GpsFixPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/GpsFixPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/GpsFixPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/GpsFixPage/Model/**'
      end
      
    end
    
    ss.subspec 'HeartbeatReportPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/HeartbeatReportPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/HeartbeatReportPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/HeartbeatReportPage/Model/**'
      end
      
    end
    
    ss.subspec 'LedSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/LedSettingsPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/LedSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/LedSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'MotionFixPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/MotionFixPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/MotionFixPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/MotionFixPage/Model/**'
      end
      
    end
    
    ss.subspec 'MqttSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/MqttSettingsPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/MqttSettingsPage/Model'
        ssss.dependency 'MKGatewayFour/Functions/MqttSettingsPage/View'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/MqttSettingsPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/MqttSettingsPage/View/**'
      end
      
    end
    
    ss.subspec 'NetworkPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/NetworkPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/NetworkPage/Model'
        
        ssss.dependency 'MKGatewayFour/Functions/NetworkSettingsPage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/NetworkSettingsV2Page/Controller'
        ssss.dependency 'MKGatewayFour/Functions/MqttSettingsPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/NetworkPage/Model/**'
      end
      
    end
    
    ss.subspec 'NetworkSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/NetworkSettingsPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/NetworkSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/NetworkSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'NetworkSettingsV2Page' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/NetworkSettingsV2Page/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/NetworkSettingsV2Page/Model'
        ssss.dependency 'MKGatewayFour/Functions/NetworkSettingsV2Page/View'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/NetworkSettingsV2Page/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/NetworkSettingsV2Page/View/**'
      end
      
    end
    
    ss.subspec 'PayloadItemsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadItemsPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/PayloadItemsPage/Model'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadItemsPage/Model/**'
      end
    end
    
    ss.subspec 'PayloadPages' do |sss|
      
      sss.subspec 'AccPayloadPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/AccPayloadPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/PayloadPages/AccPayloadPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/AccPayloadPage/Model/**'
        end
      end
      
      sss.subspec 'BeaconPayloadPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/BeaconPayloadPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/PayloadPages/BeaconPayloadPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/BeaconPayloadPage/Model/**'
        end
      end
      
      sss.subspec 'ButtonPayloadPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/ButtonPayloadPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/PayloadPages/ButtonPayloadPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/ButtonPayloadPage/Model/**'
        end
      end
      
      sss.subspec 'BXPSPayloadPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/BXPSPayloadPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/PayloadPages/BXPSPayloadPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/BXPSPayloadPage/Model/**'
        end
      end
      
      sss.subspec 'InfoPayloadPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/InfoPayloadPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/PayloadPages/InfoPayloadPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/InfoPayloadPage/Model/**'
        end
      end
      
      sss.subspec 'OtherPayloadPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/OtherPayloadPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/PayloadPages/OtherPayloadPage/Model'
          sssss.dependency 'MKGatewayFour/Functions/PayloadPages/OtherPayloadPage/View'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/OtherPayloadPage/Model/**'
        end
        
        ssss.subspec 'View' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/OtherPayloadPage/View/**'
        end
      end
      
      sss.subspec 'PirPayloadPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/PirPayloadPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/PayloadPages/PirPayloadPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/PirPayloadPage/Model/**'
        end
      end
      
      sss.subspec 'TagPayloadPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/TagPayloadPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/PayloadPages/TagPayloadPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/TagPayloadPage/Model/**'
        end
      end
      
      sss.subspec 'ThPayloadPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/ThPayloadPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/PayloadPages/ThPayloadPage/Model'
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/ThPayloadPage/Model/**'
        end
      end
      
      sss.subspec 'TlmPayloadPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/TlmPayloadPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/PayloadPages/TlmPayloadPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/TlmPayloadPage/Model/**'
        end
      end
      
      sss.subspec 'TofPayloadPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/TofPayloadPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/PayloadPages/TofPayloadPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/TofPayloadPage/Model/**'
        end
      end
      
      sss.subspec 'UidPayloadPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/UidPayloadPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/PayloadPages/UidPayloadPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/UidPayloadPage/Model/**'
        end
      end
      
      sss.subspec 'UrlPayloadPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/UrlPayloadPage/Controller/**'
        
          sssss.dependency 'MKGatewayFour/Functions/PayloadPages/UrlPayloadPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayFour/Classes/Functions/PayloadPages/UrlPayloadPage/Model/**'
        end
      end
      
    end
    
    ss.subspec 'PeriodicFixPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/PeriodicFixPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/PeriodicFixPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/PeriodicFixPage/Model/**'
      end
      
    end
    
    ss.subspec 'PeriodicScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/PeriodicScanPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/PeriodicScanPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/PeriodicScanPage/Model/**'
      end
    end
    
    ss.subspec 'PeriodicScanReportPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/PeriodicScanReportPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/PeriodicScanReportPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/PeriodicScanReportPage/Model/**'
      end
    end
    
    ss.subspec 'PositionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/PositionPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/PeriodicScanReportPage/Model'
        
        ssss.dependency 'MKGatewayFour/Functions/FixModePage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/GpsFixPage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/AxisSettingsPage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/UploadPayloadSettingsPage/Controller'

      end
    end
    
    ss.subspec 'RealtimeScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/RealtimeScanPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/RealtimeScanPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/RealtimeScanPage/Model/**'
      end
    end
    
    ss.subspec 'ScannerReportPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/ScannerReportPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/ScannerReportPage/Model'
        
        ssss.dependency 'MKGatewayFour/Functions/ScanReportModePage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/FilterSettingsPage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/PayloadItemsPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/ScannerReportPage/Model/**'
      end
    end
    
    ss.subspec 'ScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/ScanPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/ScanPage/View'
        
        ssss.dependency 'MKGatewayFour/Functions/TabBarPage/Controller'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/ScanPage/View/**'
      end
    end
    
    ss.subspec 'ScanReportModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/ScanReportModePage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/ScanReportModePage/Model'
        ssss.dependency 'MKGatewayFour/Functions/ScanReportModePage/View'
        
        ssss.dependency 'MKGatewayFour/Functions/RealtimeScanPage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/PeriodicScanPage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/PeriodicScanReportPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/ScanReportModePage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/ScanReportModePage/View/**'
      end
    end
    
    ss.subspec 'SettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/SettingsPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/SettingsPage/Model'
        
        ssss.dependency 'MKGatewayFour/Functions/LedSettingsPage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/BleParamsPage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/HeartbeatReportPage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/SystemTimePage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/BatteryManagementPage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/DeviceInfoPage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/DebuggerPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/SettingsPage/Model/**'
      end
    end
    
    ss.subspec 'SyncTime' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/SyncTime/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/SyncTime/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/SyncTime/Model/**'
      end
    end
    
    ss.subspec 'SystemTimePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/SystemTimePage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/SystemTimePage/Model'
        
        ssss.dependency 'MKGatewayFour/Functions/SyncTime/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/SystemTimePage/Model/**'
      end
    end
    
    ss.subspec 'TabBarPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/TabBarPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/NetworkPage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/PositionPage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/ScannerReportPage/Controller'
        ssss.dependency 'MKGatewayFour/Functions/SettingsPage/Controller'
      end
    end
    
    ss.subspec 'UpdatePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/UpdatePage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/UpdatePage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/UpdatePage/Model/**'
      end
    end
    
    ss.subspec 'UploadPayloadSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/UploadPayloadSettingsPage/Controller/**'
        
        ssss.dependency 'MKGatewayFour/Functions/UploadPayloadSettingsPage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKGatewayFour/Classes/Functions/UploadPayloadSettingsPage/Model/**'
      end
    end
    
    ss.dependency 'MKGatewayFour/SDK'
    ss.dependency 'MKGatewayFour/DatabaseManager'
    ss.dependency 'MKGatewayFour/CTMediator'
    ss.dependency 'MKGatewayFour/ConnectModule'
    ss.dependency 'MKGatewayFour/Expand'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'HHTransition'
    ss.dependency 'MLInputDodger'
    ss.dependency 'iOSDFULibrary',      '4.13.0'
    
  end
  
end
