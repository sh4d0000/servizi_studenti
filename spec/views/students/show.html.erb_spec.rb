require 'spec_helper'

describe "students/show" do
  before(:each) do
    @student = assign(:student, stub_model(Student,
      :surname => "Surname",
      :name => "Name",
      :gender => "Gender",
      :place_of_birth => "Place Of Birth",
      :citizenship => "Citizenship",
      :tax_code => "Tax Code"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Surname/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Gender/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Place Of Birth/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Citizenship/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Tax Code/)
  end
end
