require 'rubygems'
require 'date'
require 'logger'
require 'pathname'
require 'thread'
require File.dirname(__FILE__) + '/ruby_lib-master/lib/appium_lib'

def log_info(s = "#{$!.message} #{$@[0]} " , log_name)
  wait do
    #判断需写入的日志内容是否为空，如果为空则不需要写入
    return if not s
    #创建logger实例
    create_log_file_if_not_exit(log_name)
    logger = Logger.open(url + log_name , 'w')
    #赋予logger控制输出级别为DEBUG。DEBUG含义是：既可以在
    #控制台看到需写入的日志信息，又写入到了日志文件中
    logger.info(''){s}
    logger.close
  end
end


def create_log_file_if_not_exit(log_name)
    log_dir = url + log_name
    if !File.exist?log_dir
      logger = Logger.new(url +  log_name,10,1024000)
      logger.level = Logger::INFO
      logger.formatter = proc{|severity,datetime,prog_name,msg| "#{severity} #{prog_name} #{datetime}:#{msg}\n"}
    else

    end
end
#清除文件内上一次创建的内容，该方法调用必须写在所有方法之前
def Logdelete(log_name)
  wait do
    url = file
    io = File.open(url+ log_name)
  end
end
#创建文件夹/result/image/
def url
  begin
    wait do
      FileUtils.makedirs(Dir.pwd+"/result/log/")
    end
  rescue =>ex
    TakeTakesScreenshot()
    raise Exception,"创建文件夹异常！#{ex.message}"
  end
end
#获取当前路径
def file
  begin
    wait do
      Dir.pwd
    end
  rescue =>ex
    TakeTakesScreenshot()
    raise Exception,"当前路径异常!#{ex.message}"
  end
end