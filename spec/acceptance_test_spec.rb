require 'acceptance_test'

describe 'AcceptanceTest' do

  before(:all) do
    @cloudformation = Aws::CloudFormation::Client.new()
    @stackname = 'StelligentProjectCFStack'

    response = @cloudformation.describe_stacks({stack_name: @stackname})

    filtered_outputs = response.stacks[0].outputs.select do |output|
      output.output_key == 'URL'
    end
    
    url_output = filtered_outputs[0]
    @elb_url = url_output.output_value

    @acceptance_test = AcceptanceTest.new(@elb_url)
    @acceptance_test.wait_for_http_to_be_ready
  end

  describe '#http get request returns 200' do
    it 'returns 200' do
      expect(@acceptance_test.return_http_code).to eq('200')
    end
  end

  describe '#html_contains_message?' do
    it 'returns true if string is in html' do
      html = @acceptance_test.get_html
      expect(@acceptance_test.html_contains_message?(html)).to be true
    end
  end

end
