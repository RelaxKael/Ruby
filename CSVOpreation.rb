require 'rubygems'
require File.dirname(__FILE__) + '/ruby_lib-master/lib/appium_lib'

#XPath典型//android.view.View[1]/android.widget.FrameLayout[2]/android.widget.LinearLayout[1]
# /android.widget.LinearLayout[3]/android.widget.Button[1]
# accessibility_id关键字查询
#Name
#name关键字查询
# swipe :start_x => 207, :start_y => 647, :end_x => 455, :end_y => 646, :touchCount => 1, :duration => 0.5
# swipe :start_x => 353, :start_y => 552, :end_x => 362, :end_y => 767, :touchCount => 1, :duration => 0.5
# swipe :start_x => 395, :start_y => 784, :end_x => 388, :end_y => 569, :touchCount => 1, :duration => 0.5
# swipe :start_x => 491, :start_y => 544, :end_x => 267, :end_y => 553, :touchCount => 1, :duration => 0.5
# find_element(:xpath, "/").send_keys "111"
# find_element(:xpath, "//android.view.View[1]/android.widget.FrameLayout[2]/android.widget.ListView[1]/android.widget.TextView[9]").send_keys "111"
# shake
# execute_script "mobile: scrollTo", :element => find_element(:xpath, "//android.view.View[1]/android.widget.FrameLayout[2]/android.widget.ListView[1]/android.widget.TextView[11]").ref
# alert_dismiss
# alert_accept
#Appium::TouchAction.new :x => 419, :y => 594, :fingers => 1, :tapCount => 1, :duration => 0.5

class CSVOpreation

  def initialize(capabilities)
    @driver =  Appium::Driver.new(capabilities)
  end
  def preparedrive
    @driver.start_driver
    @driver.set_wait(10)
    # Appium.promote_appium_methods Object
  end
#点击某个元素
  def tap(value_type,content_value)
    # Appium::Common.new.wait_true{
    #
    #     exists{
    #
    #       if value_type == "1"
    #         @driver.find_element(:id,content_value)
    #       else
    #         @driver.find_element(:xpath ,content_value)
    #       end
    #     }
    # }
    if value_type == "1"
      @driver.find_element(:id,content_value).click
    else
      @driver.find_element(:xpath ,content_value).click
    end
    # begin
    # #   wait do
    #
    #     sleep(1)
    #   end
    # rescue => ex
    #   raise Exception, "#{value_content}异常,#{ex.message}"
    # end
  end
#滑动到某个元素
  def scroll_to(value_type,content_value)
    begin
        if value_type == "1"
          @driver.execute_script "mobile: scrollTo", element => find_element(:accessibility_id,content_value).ref
        else
          @driver.execute_script "mobile: scrollTo", element => find_element(:xpath,content_value).ref
        end
    rescue => ex
      raise Exception, "#{value_content}异常,#{ex.message}"
    end
  end
  #发送编辑文本
  def send_key(value_type,content_value,send_values)
    begin
        if value_type == "1"
          @driver.find_element(:accessibility_id,content_value).send_keys send_values
        else
          @driver.find_element(:xpath,content_value).send_keys send_values
        end
    rescue => ex
      raise Exception, "#{value_content}异常,#{ex.message}"
    end
  end
#滑动
  def swipe(startx,starty,endx,endy,duration)

      begin

        @driver.swipe :start_x => startx, :start_y => starty, :end_x => endx, :end_y => endy, :touchCount => 1, :duration => duration*1000
        sleep(2)
      end
    # rescue => ex
    #   raise Exception, "#{value_content}异常,#{ex.message}"
    # end
  end
  def swipe_up
    swipe(207,500,455,500,0.5)
  end
  def swipe_down
    swipe(500,500,455,207,0.5)
  end
  def swipe_right
    swipe(207,300,600,300,0.5)
  end
  def swipe_left
    swipe(600,300,200,300,0.5)
  end
#电源键点按
  def source_power()
    begin
        @driver.press_keycode(26)
    rescue => ex
      raise Exception, "#{value_content}异常,#{ex.message}"
    end
  end
#设备模拟摇晃
  def device_shake
    begin
        @driver.shake
    rescue => ex
      raise Exception, "#{value_content}异常,#{ex.message}"
    end
  end
#返回按键点按
  def machine_back()
    begin
        @driver.press_keycode(4)
    rescue => ex
      raise Exception, "#{value_content}异常,#{ex.message}"
    end
  end
#机器Home键点按
  def machine_home()
    begin
        @driver.press_keycode(82)
    rescue => ex
      raise Exception, "#{value_content}异常,#{ex.message}"
    end
  end
#音量增加键
  def volum_up()
    begin
        @driver.press_keycode(24)
    rescue => ex
      raise Exception, "#{value_content}异常,#{ex.message}"
    end
  end
#音量减少键
  def volum_down()
    begin
        @driver.press_keycode(25)
    rescue => ex
      raise Exception, "#{value_content}异常,#{ex.message}"
    end
  end
#touch手势
  def touch_action(x,y,tap_count,finger_count,duration)
    #[:move_to, :long_press, :double_tap, :two_finger_tap, :press, :release, :tap, :wait, :perform]
    begin
      wait do
        Appium::TouchAction.new :x => x, :y => y, :fingers => finger_count, :tapCount => tap_count, :duration => duration*1000
      end
    rescue => ex
      raise Exception, "#{value_content}异常,#{ex.message}"
    end
  end
  def long_press(value_type,value_content)
    begin
        if value_type == "1"
          element = @driver.find_element(:accessibility_id,value_content)
        else
          element = @driver.find_element(:xpath,value_content)
        end
        Appium::TouchAction.new.long_press(element:element,x:0.5,y:0.5).release(element:element).perform
    rescue => ex
      raise Exception, "#{value_content}异常,#{ex.message}"
    end
  end
  def wait_timeout(timeout)
    sleep(timeout.to_i)
  end
  def screen_shot(feature_name)
    if !File.directory?(Dir.pwd + '/result/image/')
        FileUtils.makedirs(Dir.pwd + '/result/image/')
    end
    begin
      @driver.screenshot(Dir.pwd + '/result/image/' + feature_name + '.jpg')

    end
  end
  def finishdrive
    @driver.driver_quit
    # @driver = nil
    # finish_test = true
    # yield finish_test
  end
end