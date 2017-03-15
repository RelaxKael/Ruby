
class TestObject
  #测试用例命名
  @feature_name = nil
  @start_activity_key = nil
  #测试流程
  @case_hash = nil
  # @step_desc = nil
  # @accessibility_id = nil
  # @control_action = nil
  # @send_key = nil
  # @expectation = nil
  # @accessibility_id/xpath = 1
  #测试结果
  @result = false
  def initialize(feature_name,start_activity_key)
      @feature_name = feature_name
      @start_activity_key = start_activity_key
      @case_hash_array = []
  end
  def ap_hash(hash)
    @case_hash_array.push(hash)
  end
  def return_start_activity_key
    @start_activity_key
  end
  def return_feature_name
    @feature_name
  end
  def return_test_case_array
    @case_hash_array
  end
end