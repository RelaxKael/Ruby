
#     # Start Android driver
#     opts = {
#              caps: {
#                platformName: :android,
#                app: '/path/to/my.apk'
#              },
#              appium_lib: {
#                wait_timeout: 30,
#                wait_interval: 1
#              }
#            }
# capabilities = {
#     'appium-version': '1.0',
#     'platformName': 'Android',
#     'platformVersion': '5.1',
#     'deviceName': 'Alps WP S6',
#     'app': '/Users/xylt/Downloads/ruby_lib-master/android_tests/api.apk',
#     'appPackage' => 'io.appium.android.apis',
#     'appActivity' => 'ApiDemos'
# }
# require File.dirname(__FILE__) + '/ruby_lib-master/lib/appium_lib'
def config_hash(app_package_name,start_activity,test_app_file_path,device_name)
#创建一个hash键值对
  return_hash = Hash.new
  caps = Hash.new
  caps['appium-version'] = '1.0'
  caps['platformName'] = 'Android'
  caps['app'] = test_app_file_path
  # caps['appium'] = Appium::VERSION.to_s
  caps['platformVersion'] = '5.1'
  caps['deviceName'] = device_name
  caps['appActivity'] = start_activity
  caps['appPackage'] = app_package_name

  return_hash['caps'] = caps

  appium_lib = Hash.new
  appium_lib['wait_timeout'] = 30
  appium_lib['wait_interval'] = 5
  return_hash['appium_lib'] = appium_lib
  return_hash
end