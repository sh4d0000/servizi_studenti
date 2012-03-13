require 'spec_helper'

describe "students/edit" do
  before(:each) do
    @student = assign(:student, stub_model(Student,
      :surname => "MyString",
      :name => "MyString",
      :gender => "MyString",
      :place_of_birth => "MyString",
      :citizenship => "MyString",
      :tax_code => "MyString"
    ))
  end

  it "renders the edit student form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => students_path(@student), :method => "post" do
      assert_select "input#student_surname", :name => "student[surname]"
      assert_select "input#student_name", :name => "student[name]"
      assert_select "input#student_gender", :name => "student[gender]"
      assert_select "input#student_place_of_birth", :name => "student[place_of_birth]"
      assert_select "input#student_citizenship", :name => "student[citizenship]"
      assert_select "input#student_tax_code", :name => "student[tax_code]"
    end
  end
end
