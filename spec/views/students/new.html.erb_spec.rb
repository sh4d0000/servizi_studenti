require 'spec_helper'

describe "students/new" do
  before(:each) do
    assign(:student, stub_model(Student,
      :surname => "MyString",
      :name => "MyString",
      :gender => "MyString",
      :place_of_birth => "MyString",
      :citizenship => "MyString",
      :tax_code => "MyString"
    ).as_new_record)
  end

  it "renders new student form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => students_path, :method => "post" do
      assert_select "input#student_surname", :name => "student[surname]"
      assert_select "input#student_name", :name => "student[name]"
      assert_select "input#student_gender", :name => "student[gender]"
      assert_select "input#student_place_of_birth", :name => "student[place_of_birth]"
      assert_select "input#student_citizenship", :name => "student[citizenship]"
      assert_select "input#student_tax_code", :name => "student[tax_code]"
    end
  end
end
