require 'csv'
require 'spec'
require 'fakefs/safe'
require 'hashdiff'
require File.dirname(__FILE__) + '/csv_config'
require File.dirname(__FILE__) + '/CSVOpreation'
require File.dirname(__FILE__) + '/test_object'


def start_csv_file_test(csvfilepath,app_package_name,test_app_file_path,device_name)

  if !File.exist?(csvfilepath)
    return
  end
  line_num = 0
  test_case_array  = []
  CSV.foreach(csvfilepath) do |row|
    line_num += 1
    if line_num == 1
      next
    end
    sub_element = row[0]
    next_element = row[1]
    third_element = row[2]
    #创建一个实体对象
    if sub_element != nil
      test_case = TestObject.new(sub_element,next_element)
      test_case_array.push(test_case)
    end
    if third_element != nil
      test_hash = Hash.new
      test_hash['step_desc'] = third_element
      test_hash['accessibility_id/xpath'] = row[3]
      test_hash['value_content'] = row[4]
      test_hash['control_action'] = row[5]
      test_hash['send_key'] = row[6]
      test_hash['expectation'] = row[7]
      if test_case != nil
        test_case.ap_hash(test_hash)
      else
        current_case = test_case_array.last
        current_case.ap_hash(test_hash)
      end
    else
      next
    end
  end
  puts test_case_array
  start_test_process(test_case_array,app_package_name,test_app_file_path,device_name)

end



def start_test_process(test_case_array,app_package_name,test_app_file_path,device_name)
  for i in 0..test_case_array.length-1
    test_case = test_case_array[i]
    do_single_task(test_case,app_package_name,test_app_file_path,device_name)

  end
end

def do_single_task(test_case,app_package_name,test_app_file_path,device_name)
    if test_case == nil
      return
    end
    csv_config = config_hash(app_package_name,test_case.return_start_activity_key,test_app_file_path,device_name)
    csv_opreation = CSVOpreation.new(csv_config)
    csv_opreation.preparedrive
    sleep(1.5)
    feature_name = test_case.return_feature_name
    test_case.return_test_case_array.each { |case_hash|
        value_type = case_hash['accessibility_id/xpath']
        control_action = case_hash['control_action']
        if control_action == 'click'
          csv_opreation.tap(value_type,case_hash['value_content'])
        elsif control_action == 'swipe_left'
          csv_opreation.swipe_left
        elsif control_action == 'swipe_right'
          csv_opreation.swipe_right
        elsif control_action == 'wait'
          csv_opreation.wait_timeout(case_hash['send_key'])
        elsif control_action == 'long_press'
          csv_opreation.long_press(value_type,case_hash['value_content'])
        elsif control_action.equal?'scroll_to'
          csv_opreation.scroll_to(value_type,case_hash['value_content'])
        end
    }
    # if test_case.return_test_case_array[test_case.return_test_case_array.length-1] == case_hash
      csv_opreation.screen_shot(feature_name)
    # end
    csv_opreation.finishdrive

end
 start_csv_file_test('/Users/xylt/Documents/test_csv.csv','io.appium.android.apis','/Users/xylt/Downloads/ruby_lib-master/android_tests/api.apk','Alps WP S6')
# csv_file = ARGV[0]
# raise 'file not exist at #{csvfile}' unless File.exist?csv_file
#
# package_name = ARGV[1]
#
# raise 'don\'t hava a packagename' unless package_name != nil?
#
# app_file_path = ARGV[2]
#
# raise 'don\'t hava a apk' unless app_file_path != nil?
#
# device_name = ARGV[3]
#
# raise 'deviceName can\'t be null !' unless device_name != nil?
#
# start_csv_file_test(ARGV[0],ARGV[1],ARGV[2],ARGV[3])