require 'spec_helper'

describe "students/index" do
  before(:each) do
    assign(:students, [
      stub_model(Student,
        :surname => "Surname",
        :name => "Name",
        :gender => "Gender",
        :place_of_birth => "Place Of Birth",
        :citizenship => "Citizenship",
        :tax_code => "Tax Code"
      ),
      stub_model(Student,
        :surname => "Surname",
        :name => "Name",
        :gender => "Gender",
        :place_of_birth => "Place Of Birth",
        :citizenship => "Citizenship",
        :tax_code => "Tax Code"
      )
    ])
  end

  it "renders a list of students" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Surname".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Gender".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Place Of Birth".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Citizenship".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Tax Code".to_s, :count => 2
  end
end
