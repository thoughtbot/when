require File.join(File.dirname(__FILE__), 'test_helper')
require File.join(File.dirname(__FILE__), 'fixtures', 'company')

class WhenTest < Test::Unit::TestCase

  def test_should_set_its_attribute_1_if_its_before_create_if_with_proc_condition_when_sent_save_on_initial_creation
    company = Company.new :attribute_1 => 'before_create_if_with_proc_condition'

    assert company.save_without_validation
    assert_equal 'attribute_1', company.attribute_1

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_1
  end

  def test_should_set_its_attribute_2_unless_its_before_create_unless_with_proc_condition_when_sent_save_on_initial_creation
    company = Company.new :attribute_2 => 'before_create_unless_with_proc_condition'

    assert company.save_without_validation
    assert_equal 'before_create_unless_with_proc_condition', company.attribute_2

    company = Company.new

    assert company.save_without_validation
    assert_equal 'attribute_2', company.attribute_2
  end

  def test_should_set_its_attribute_3_if_its_after_create_if_with_proc_condition_when_sent_save_on_initial_creation
    company = Company.new :attribute_3 => 'after_create_if_with_proc_condition'

    assert company.save_without_validation
    assert_equal 'attribute_3', company.attribute_3

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_3
  end

  def test_should_set_its_attribute_4_unless_its_after_create_unless_with_proc_condition_when_sent_save_on_initial_creation
    company = Company.new :attribute_4 => 'after_create_unless_with_proc_condition'

    assert company.save_without_validation
    assert_equal 'after_create_unless_with_proc_condition', company.attribute_4

    company = Company.new

    assert company.save_without_validation
    assert_equal 'attribute_4', company.attribute_4
  end

  def test_should_set_its_attribute_5_if_its_before_save_if_with_proc_condition_when_sent_save
    company = Company.new :attribute_5 => 'before_save_if_with_proc_condition'

    assert company.save_without_validation
    assert_equal 'attribute_5', company.attribute_5

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_5

    company.attribute_5 = 'before_save_if_with_proc_condition'

    assert company.save_without_validation
    assert_equal 'attribute_5', company.attribute_5
  end

  def test_should_set_its_attribute_6_unless_its_before_save_unless_with_proc_condition_when_sent_save
    company = Company.new :attribute_6 => 'before_save_unless_with_proc_condition'

    assert company.save_without_validation
    assert_equal 'before_save_unless_with_proc_condition', company.attribute_6
    assert company.save_without_validation
    assert_equal 'before_save_unless_with_proc_condition', company.attribute_6

    company = Company.new

    assert company.save_without_validation
    assert_equal 'attribute_6', company.attribute_6

    company.attribute_6 = ''

    assert company.save_without_validation
    assert_equal 'attribute_6', company.attribute_6
  end

  def test_should_set_its_attribute_7_if_its_after_save_if_with_proc_condition_when_sent_save
    company = Company.new :attribute_7 => 'after_save_if_with_proc_condition'

    assert company.save_without_validation
    assert_equal 'attribute_7', company.attribute_7

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_7

    company.attribute_7 = 'after_save_if_with_proc_condition'

    assert company.save_without_validation
    assert_equal 'attribute_7', company.attribute_7
  end

  def test_should_set_its_attribute_8_unless_its_after_save_unless_with_proc_condition_when_sent_save
    company = Company.new :attribute_8 => 'after_save_unless_with_proc_condition'

    assert company.save_without_validation
    assert_equal 'after_save_unless_with_proc_condition', company.attribute_8
    assert company.save_without_validation
    assert_equal 'after_save_unless_with_proc_condition', company.attribute_8

    company = Company.new

    assert company.save_without_validation
    assert_equal 'attribute_8', company.attribute_8

    company.attribute_8 = ''

    assert company.save_without_validation
    assert_equal 'attribute_8', company.attribute_8
  end

  def test_should_set_its_attribute_9_if_its_before_destroy_if_with_proc_condition_when_sent_destroy
    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_9

    company.attribute_9 = 'before_destroy_if_with_proc_condition'
    assert company.destroy
    assert_equal 'attribute_9', company.attribute_9

    company = Company.new

    assert company.save_without_validation
    assert company.destroy
    assert_nil company.attribute_9
  end

  def test_should_set_its_attribute_10_unless_its_before_destroy_unless_with_proc_condition_when_sent_destroy
    company = Company.new :attribute_10 => 'before_destroy_unless_with_proc_condition'

    assert company.save_without_validation
    assert company.destroy
    assert_equal 'before_destroy_unless_with_proc_condition', company.attribute_10

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_10
    assert company.destroy
    assert_equal 'attribute_10', company.attribute_10
  end

  def test_should_set_its_attribute_11_if_its_after_destroy_if_with_proc_condition_when_sent_destroy
    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_11

    company.attribute_11 = 'after_destroy_if_with_proc_condition'
    assert company.destroy
    assert_equal 'attribute_11', company.attribute_11

    company = Company.new

    assert company.save_without_validation
    assert company.destroy
    assert_nil company.attribute_11
  end

  def test_should_set_its_attribute_12_unless_its_after_destroy_unless_with_proc_condition_when_sent_destroy
    company = Company.new :attribute_12 => 'after_destroy_unless_with_proc_condition'

    assert company.save_without_validation
    assert company.destroy
    assert_equal 'after_destroy_unless_with_proc_condition', company.attribute_12

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_12
    assert company.destroy
    assert_equal 'attribute_12', company.attribute_12
  end

  def test_should_set_its_attribute_13_if_its_before_update_if_with_proc_condition_when_sent_save_on_an_update
    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_13

    company.attribute_13 = 'before_update_if_with_proc_condition'
    assert company.save_without_validation
    assert_equal 'attribute_13', company.attribute_13

    company = Company.new

    assert company.save_without_validation
    assert company.save_without_validation
    assert_nil company.attribute_13
  end

  def test_should_set_its_attribute_14_unless_its_before_update_unless_with_proc_condition_when_sent_save_on_an_update
    company = Company.new :attribute_14 => 'before_update_unless_with_proc_condition'

    assert company.save_without_validation
    assert company.save_without_validation
    assert_equal 'before_update_unless_with_proc_condition', company.attribute_14

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_14
    assert company.save_without_validation
    assert_equal 'attribute_14', company.attribute_14
  end

  def test_should_set_its_attribute_15_if_its_after_update_if_with_proc_condition_when_sent_save_on_an_update
    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_15

    company.attribute_15 = 'after_update_if_with_proc_condition'
    assert company.save_without_validation
    assert_equal 'attribute_15', company.attribute_15

    company = Company.new

    assert company.save_without_validation
    assert company.save_without_validation
    assert_nil company.attribute_15
  end

  def test_should_set_its_attribute_16_unless_its_after_update_unless_with_proc_condition_when_sent_on_an_update
    company = Company.new :attribute_16 => 'after_update_unless_with_proc_condition'

    assert company.save_without_validation
    assert company.save_without_validation
    assert_equal 'after_update_unless_with_proc_condition', company.attribute_16

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_16
    assert company.save_without_validation
    assert_equal 'attribute_16', company.attribute_16
  end

  def test_should_set_its_attribute_17_if_its_before_validation_if_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_17 => 'before_validation_if_with_proc_condition'
    company.valid?
    assert_equal 'attribute_17', company.attribute_17

    company = Company.new
    company.valid?
    assert_nil company.attribute_17
  end

  def test_should_set_its_attribute_18_unless_its_before_validation_unless_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_18 => 'before_validation_unless_with_proc_condition'
    company.valid?
    assert_equal 'before_validation_unless_with_proc_condition', company.attribute_18

    company = Company.new
    company.valid?
    assert_equal 'attribute_18', company.attribute_18
  end

  def test_should_set_its_attribute_19_if_its_after_validation_if_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_19 => 'after_validation_if_with_proc_condition'
    company.valid?
    assert_equal 'attribute_19', company.attribute_19

    company = Company.new
    company.valid?
    assert_nil company.attribute_19
  end

  def test_should_set_its_attribute_20_unless_its_after_validation_unless_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_20 => 'after_validation_unless_with_proc_condition'
    company.valid?
    assert_equal 'after_validation_unless_with_proc_condition', company.attribute_20

    company = Company.new
    company.valid?
    assert_equal 'attribute_20', company.attribute_20
  end

  def test_should_set_its_attribute_21_if_its_before_validation_on_create_if_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_21 => 'before_validation_on_create_if_with_proc_condition'
    company.valid?
    assert_equal 'attribute_21', company.attribute_21

    company = Company.new
    company.valid?
    assert_nil company.attribute_21
  end

  def test_should_set_its_attribute_22_unless_its_before_validation_on_create_unless_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_22 => 'before_validation_on_create_unless_with_proc_condition'
    company.valid?
    assert_equal 'before_validation_on_create_unless_with_proc_condition', company.attribute_22

    company = Company.new
    company.valid?
    assert_equal 'attribute_22', company.attribute_22
  end

  def test_should_set_its_attribute_23_if_its_after_validation_on_create_if_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_23 => 'after_validation_on_create_if_with_proc_condition'
    company.valid?
    assert_equal 'attribute_23', company.attribute_23

    company = Company.new
    company.valid?
    assert_nil company.attribute_23
  end

  def test_should_set_its_attribute_24_unless_its_after_validation_on_create_unless_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_24 => 'after_validation_on_create_unless_with_proc_condition'
    company.valid?
    assert_equal 'after_validation_on_create_unless_with_proc_condition', company.attribute_24

    company = Company.new
    company.valid?
    assert_equal 'attribute_24', company.attribute_24
  end

  def test_should_set_its_attribute_25_if_its_before_validation_on_update_if_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_25 => 'before_validation_on_update_if_with_proc_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_25', company.attribute_25

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_nil company.attribute_25
  end

  def test_should_set_its_attribute_26_unless_its_before_validation_on_update_unless_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_26 => 'before_validation_on_update_unless_with_proc_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'before_validation_on_update_unless_with_proc_condition', company.attribute_26

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_26', company.attribute_26
  end

  def test_should_set_its_attribute_27_if_its_after_validation_on_update_if_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_27 => 'after_validation_on_update_if_with_proc_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_27', company.attribute_27

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_nil company.attribute_27
  end

  def test_should_set_its_attribute_28_unless_its_after_validation_on_update_unless_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_28 => 'after_validation_on_update_unless_with_proc_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'after_validation_on_update_unless_with_proc_condition', company.attribute_28

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_28', company.attribute_28
  end

  def test_should_set_its_attribute_29_if_its_after_initialize_if_with_proc_condition_when_sent_new
    company = Company.new :attribute_29 => 'after_initialize_if_with_proc_condition'
    assert_equal 'attribute_29', company.attribute_29

    company = Company.new
    assert_nil company.attribute_29
  end

  def test_should_set_its_attribute_30_unless_its_after_initialize_unless_with_proc_condition_when_sent_new
    company = Company.new :attribute_30 => 'after_initialize_unless_with_proc_condition'
    assert_equal 'after_initialize_unless_with_proc_condition', company.attribute_30

    company = Company.new
    assert_equal 'attribute_30', company.attribute_30
  end

  def test_should_set_its_attribute_31_if_its_name_is_after_find_if_with_proc_condition_when_sent_find
    company = Company.new :name => 'after_find_if_with_proc_condition'
    assert company.save

    company = Company.find company.id
    assert_equal 'attribute_31', company.attribute_31
  end

  def test_should_set_its_attribute_32_unless_its_name_is_after_find_unless_with_proc_condition_when_sent_find
    company = Company.new :name => 'after_find_unless_with_proc_condition'
    assert company.save

    company = Company.find company.id
    assert_nil company.attribute_32

    company = Company.new :name => 'name'
    assert company.save

    company = Company.find company.id
    assert_equal 'attribute_32', company.attribute_32
  end

  def test_should_set_its_attribute_33_if_its_validate_if_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_33 => 'validate_if_with_proc_condition'
    company.valid?
    assert_equal 'attribute_33', company.attribute_33

    company = Company.new
    company.valid?
    assert_nil company.attribute_33
  end

  def test_should_set_its_attribute_34_unless_its_validate_unless_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_34 => 'validate_unless_with_proc_condition'
    company.valid?
    assert_equal 'validate_unless_with_proc_condition', company.attribute_34

    company = Company.new
    company.valid?
    assert_equal 'attribute_34', company.attribute_34
  end

  def test_should_set_its_attribute_35_if_its_validate_on_create_if_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_35 => 'validate_on_create_if_with_proc_condition'
    company.valid?
    assert_equal 'attribute_35', company.attribute_35

    company = Company.new
    company.valid?
    assert_nil company.attribute_35
  end

  def test_should_set_its_attribute_36_unless_its_validate_on_create_unless_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_36 => 'validate_on_create_unless_with_proc_condition'
    company.valid?
    assert_equal 'validate_on_create_unless_with_proc_condition', company.attribute_36

    company = Company.new
    company.valid?
    assert_equal 'attribute_36', company.attribute_36
  end

  def test_should_set_its_attribute_37_if_its_validate_on_update_if_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_37 => 'validate_on_update_if_with_proc_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_37', company.attribute_37

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_nil company.attribute_37
  end

  def test_should_set_its_attribute_38_unless_its_validate_on_update_unless_with_proc_condition_when_sent_valid?
    company = Company.new :attribute_38 => 'validate_on_update_unless_with_proc_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'validate_on_update_unless_with_proc_condition', company.attribute_38

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_38', company.attribute_38
  end

  def test_should_set_its_attribute_39_if_its_before_create_if_with_string_condition_when_sent_save_on_initial_creation
    company = Company.new :attribute_39 => 'before_create_if_with_string_condition'

    assert company.save_without_validation
    assert_equal 'attribute_39', company.attribute_39

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_39
  end

  def test_should_set_its_attribute_40_unless_its_before_create_unless_with_string_condition_when_sent_save_on_initial_creation
    company = Company.new :attribute_40 => 'before_create_unless_with_string_condition'

    assert company.save_without_validation
    assert_equal 'before_create_unless_with_string_condition', company.attribute_40

    company = Company.new

    assert company.save_without_validation
    assert_equal 'attribute_40', company.attribute_40
  end

  def test_should_set_its_attribute_41_if_its_after_create_if_with_string_condition_when_sent_save_on_initial_creation
    company = Company.new :attribute_41 => 'after_create_if_with_string_condition'

    assert company.save_without_validation
    assert_equal 'attribute_41', company.attribute_41

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_41
  end

  def test_should_set_its_attribute_42_unless_its_after_create_unless_with_string_condition_when_sent_save_on_initial_creation
    company = Company.new :attribute_42 => 'after_create_unless_with_string_condition'

    assert company.save_without_validation
    assert_equal 'after_create_unless_with_string_condition', company.attribute_42

    company = Company.new

    assert company.save_without_validation
    assert_equal 'attribute_42', company.attribute_42
  end

  def test_should_set_its_attribute_43_if_its_before_save_if_with_string_condition_when_sent_save
    company = Company.new :attribute_43 => 'before_save_if_with_string_condition'

    assert company.save_without_validation
    assert_equal 'attribute_43', company.attribute_43

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_43

    company.attribute_43 = 'before_save_if_with_string_condition'

    assert company.save_without_validation
    assert_equal 'attribute_43', company.attribute_43
  end

  def test_should_set_its_attribute_44_unless_its_before_save_unless_with_string_condition_when_sent_save
    company = Company.new :attribute_44 => 'before_save_unless_with_string_condition'

    assert company.save_without_validation
    assert_equal 'before_save_unless_with_string_condition', company.attribute_44
    assert company.save_without_validation
    assert_equal 'before_save_unless_with_string_condition', company.attribute_44

    company = Company.new

    assert company.save_without_validation
    assert_equal 'attribute_44', company.attribute_44

    company.attribute_44 = ''

    assert company.save_without_validation
    assert_equal 'attribute_44', company.attribute_44
  end

  def test_should_set_its_attribute_45_if_its_after_save_if_with_string_condition_when_sent_save
    company = Company.new :attribute_45 => 'after_save_if_with_string_condition'

    assert company.save_without_validation
    assert_equal 'attribute_45', company.attribute_45

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_45

    company.attribute_45 = 'after_save_if_with_string_condition'

    assert company.save_without_validation
    assert_equal 'attribute_45', company.attribute_45
  end

  def test_should_set_its_attribute_46_unless_its_after_save_unless_with_string_condition_when_sent_save
    company = Company.new :attribute_46 => 'after_save_unless_with_string_condition'

    assert company.save_without_validation
    assert_equal 'after_save_unless_with_string_condition', company.attribute_46
    assert company.save_without_validation
    assert_equal 'after_save_unless_with_string_condition', company.attribute_46

    company = Company.new

    assert company.save_without_validation
    assert_equal 'attribute_46', company.attribute_46

    company.attribute_46 = ''

    assert company.save_without_validation
    assert_equal 'attribute_46', company.attribute_46
  end

  def test_should_set_its_attribute_47_if_its_before_destroy_if_with_string_condition_when_sent_destroy
    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_47

    company.attribute_47 = 'before_destroy_if_with_string_condition'
    assert company.destroy
    assert_equal 'attribute_47', company.attribute_47

    company = Company.new

    assert company.save_without_validation
    assert company.destroy
    assert_nil company.attribute_47
  end

  def test_should_set_its_attribute_48_unless_its_before_destroy_unless_with_string_condition_when_sent_destroy
    company = Company.new :attribute_48 => 'before_destroy_unless_with_string_condition'

    assert company.save_without_validation
    assert company.destroy
    assert_equal 'before_destroy_unless_with_string_condition', company.attribute_48

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_48
    assert company.destroy
    assert_equal 'attribute_48', company.attribute_48
  end

  def test_should_set_its_attribute_49_if_its_after_destroy_if_with_string_condition_when_sent_destroy
    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_49

    company.attribute_49 = 'after_destroy_if_with_string_condition'
    assert company.destroy
    assert_equal 'attribute_49', company.attribute_49

    company = Company.new

    assert company.save_without_validation
    assert company.destroy
    assert_nil company.attribute_49
  end

  def test_should_set_its_attribute_50_unless_its_after_destroy_unless_with_string_condition_when_sent_destroy
    company = Company.new :attribute_50 => 'after_destroy_unless_with_string_condition'

    assert company.save_without_validation
    assert company.destroy
    assert_equal 'after_destroy_unless_with_string_condition', company.attribute_50

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_50
    assert company.destroy
    assert_equal 'attribute_50', company.attribute_50
  end

  def test_should_set_its_attribute_51_if_its_before_update_if_with_string_condition_when_sent_save_on_an_update
    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_51

    company.attribute_51 = 'before_update_if_with_string_condition'
    assert company.save_without_validation
    assert_equal 'attribute_51', company.attribute_51

    company = Company.new

    assert company.save_without_validation
    assert company.save_without_validation
    assert_nil company.attribute_51
  end

  def test_should_set_its_attribute_52_unless_its_before_update_unless_with_string_condition_when_sent_save_on_an_update
    company = Company.new :attribute_52 => 'before_update_unless_with_string_condition'

    assert company.save_without_validation
    assert company.save_without_validation
    assert_equal 'before_update_unless_with_string_condition', company.attribute_52

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_52
    assert company.save_without_validation
    assert_equal 'attribute_52', company.attribute_52
  end

  def test_should_set_its_attribute_53_if_its_after_update_if_with_string_condition_when_sent_save_on_an_update
    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_53

    company.attribute_53 = 'after_update_if_with_string_condition'
    assert company.save_without_validation
    assert_equal 'attribute_53', company.attribute_53

    company = Company.new

    assert company.save_without_validation
    assert company.save_without_validation
    assert_nil company.attribute_53
  end

  def test_should_set_its_attribute_54_unless_its_after_update_unless_with_string_condition_when_sent_on_an_update
    company = Company.new :attribute_54 => 'after_update_unless_with_string_condition'

    assert company.save_without_validation
    assert company.save_without_validation
    assert_equal 'after_update_unless_with_string_condition', company.attribute_54

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_54
    assert company.save_without_validation
    assert_equal 'attribute_54', company.attribute_54
  end

  def test_should_set_its_attribute_55_if_its_before_validation_if_with_string_condition_when_sent_valid?
    company = Company.new :attribute_55 => 'before_validation_if_with_string_condition'
    company.valid?
    assert_equal 'attribute_55', company.attribute_55

    company = Company.new
    company.valid?
    assert_nil company.attribute_55
  end

  def test_should_set_its_attribute_56_unless_its_before_validation_unless_with_string_condition_when_sent_valid?
    company = Company.new :attribute_56 => 'before_validation_unless_with_string_condition'
    company.valid?
    assert_equal 'before_validation_unless_with_string_condition', company.attribute_56

    company = Company.new
    company.valid?
    assert_equal 'attribute_56', company.attribute_56
  end

  def test_should_set_its_attribute_57_if_its_after_validation_if_with_string_condition_when_sent_valid?
    company = Company.new :attribute_57 => 'after_validation_if_with_string_condition'
    company.valid?
    assert_equal 'attribute_57', company.attribute_57

    company = Company.new
    company.valid?
    assert_nil company.attribute_57
  end

  def test_should_set_its_attribute_58_unless_its_after_validation_unless_with_string_condition_when_sent_valid?
    company = Company.new :attribute_58 => 'after_validation_unless_with_string_condition'
    company.valid?
    assert_equal 'after_validation_unless_with_string_condition', company.attribute_58

    company = Company.new
    company.valid?
    assert_equal 'attribute_58', company.attribute_58
  end

  def test_should_set_its_attribute_59_if_its_before_validation_on_create_if_with_string_condition_when_sent_valid?
    company = Company.new :attribute_59 => 'before_validation_on_create_if_with_string_condition'
    company.valid?
    assert_equal 'attribute_59', company.attribute_59

    company = Company.new
    company.valid?
    assert_nil company.attribute_59
  end

  def test_should_set_its_attribute_60_unless_its_before_validation_on_create_unless_with_string_condition_when_sent_valid?
    company = Company.new :attribute_60 => 'before_validation_on_create_unless_with_string_condition'
    company.valid?
    assert_equal 'before_validation_on_create_unless_with_string_condition', company.attribute_60

    company = Company.new
    company.valid?
    assert_equal 'attribute_60', company.attribute_60
  end

  def test_should_set_its_attribute_61_if_its_after_validation_on_create_if_with_string_condition_when_sent_valid?
    company = Company.new :attribute_61 => 'after_validation_on_create_if_with_string_condition'
    company.valid?
    assert_equal 'attribute_61', company.attribute_61

    company = Company.new
    company.valid?
    assert_nil company.attribute_61
  end

  def test_should_set_its_attribute_62_unless_its_after_validation_on_create_unless_with_string_condition_when_sent_valid?
    company = Company.new :attribute_62 => 'after_validation_on_create_unless_with_string_condition'
    company.valid?
    assert_equal 'after_validation_on_create_unless_with_string_condition', company.attribute_62

    company = Company.new
    company.valid?
    assert_equal 'attribute_62', company.attribute_62
  end

  def test_should_set_its_attribute_63_if_its_before_validation_on_update_if_with_string_condition_when_sent_valid?
    company = Company.new :attribute_63 => 'before_validation_on_update_if_with_string_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_63', company.attribute_63

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_nil company.attribute_63
  end

  def test_should_set_its_attribute_64_unless_its_before_validation_on_update_unless_with_string_condition_when_sent_valid?
    company = Company.new :attribute_64 => 'before_validation_on_update_unless_with_string_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'before_validation_on_update_unless_with_string_condition', company.attribute_64

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_64', company.attribute_64
  end

  def test_should_set_its_attribute_65_if_its_after_validation_on_update_if_with_string_condition_when_sent_valid?
    company = Company.new :attribute_65 => 'after_validation_on_update_if_with_string_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_65', company.attribute_65

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_nil company.attribute_65
  end

  def test_should_set_its_attribute_66_unless_its_after_validation_on_update_unless_with_string_condition_when_sent_valid?
    company = Company.new :attribute_66 => 'after_validation_on_update_unless_with_string_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'after_validation_on_update_unless_with_string_condition', company.attribute_66

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_66', company.attribute_66
  end

  def test_should_set_its_attribute_67_if_its_after_initialize_if_with_string_condition_when_sent_new
    company = Company.new :attribute_67 => 'after_initialize_if_with_string_condition'
    assert_equal 'attribute_67', company.attribute_67

    company = Company.new
    assert_nil company.attribute_67
  end

  def test_should_set_its_attribute_68_unless_its_after_initialize_unless_with_string_condition_when_sent_new
    company = Company.new :attribute_68 => 'after_initialize_unless_with_string_condition'
    assert_equal 'after_initialize_unless_with_string_condition', company.attribute_68

    company = Company.new
    assert_equal 'attribute_68', company.attribute_68
  end

  def test_should_set_its_attribute_69_if_its_name_is_after_find_if_with_string_condition_when_sent_find
    company = Company.new :name => 'after_find_if_with_string_condition'
    assert company.save

    company = Company.find company.id
    assert_equal 'attribute_69', company.attribute_69
  end

  def test_should_set_its_attribute_70_unless_its_name_is_after_find_unless_with_string_condition_when_sent_find
    company = Company.new :name => 'after_find_unless_with_string_condition'
    assert company.save

    company = Company.find company.id
    assert_nil company.attribute_70

    company = Company.new :name => 'name'
    assert company.save

    company = Company.find company.id
    assert_equal 'attribute_70', company.attribute_70
  end

  def test_should_set_its_attribute_71_if_its_validate_if_with_string_condition_when_sent_valid?
    company = Company.new :attribute_71 => 'validate_if_with_string_condition'
    company.valid?
    assert_equal 'attribute_71', company.attribute_71

    company = Company.new
    company.valid?
    assert_nil company.attribute_71
  end

  def test_should_set_its_attribute_72_unless_its_validate_unless_with_string_condition_when_sent_valid?
    company = Company.new :attribute_72 => 'validate_unless_with_string_condition'
    company.valid?
    assert_equal 'validate_unless_with_string_condition', company.attribute_72

    company = Company.new
    company.valid?
    assert_equal 'attribute_72', company.attribute_72
  end

  def test_should_set_its_attribute_73_if_its_validate_on_create_if_with_string_condition_when_sent_valid?
    company = Company.new :attribute_73 => 'validate_on_create_if_with_string_condition'
    company.valid?
    assert_equal 'attribute_73', company.attribute_73

    company = Company.new
    company.valid?
    assert_nil company.attribute_73
  end

  def test_should_set_its_attribute_74_unless_its_validate_on_create_unless_with_string_condition_when_sent_valid?
    company = Company.new :attribute_74 => 'validate_on_create_unless_with_string_condition'
    company.valid?
    assert_equal 'validate_on_create_unless_with_string_condition', company.attribute_74

    company = Company.new
    company.valid?
    assert_equal 'attribute_74', company.attribute_74
  end

  def test_should_set_its_attribute_75_if_its_validate_on_update_if_with_string_condition_when_sent_valid?
    company = Company.new :attribute_75 => 'validate_on_update_if_with_string_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_75', company.attribute_75

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_nil company.attribute_75
  end

  def test_should_set_its_attribute_76_unless_its_validate_on_update_unless_with_string_condition_when_sent_valid?
    company = Company.new :attribute_76 => 'validate_on_update_unless_with_string_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'validate_on_update_unless_with_string_condition', company.attribute_76

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_76', company.attribute_76
  end

  def test_should_set_its_attribute_77_if_its_before_create_if_with_symbol_condition_when_sent_save_on_initial_creation
    company = Company.new :attribute_77 => 'before_create_if_with_symbol_condition'

    assert company.save_without_validation
    assert_equal 'attribute_77', company.attribute_77

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_77
  end

  def test_should_set_its_attribute_78_unless_its_before_create_unless_with_symbol_condition_when_sent_save_on_initial_creation
    company = Company.new :attribute_78 => 'before_create_unless_with_symbol_condition'

    assert company.save_without_validation
    assert_equal 'before_create_unless_with_symbol_condition', company.attribute_78

    company = Company.new

    assert company.save_without_validation
    assert_equal 'attribute_78', company.attribute_78
  end

  def test_should_set_its_attribute_79_if_its_after_create_if_with_symbol_condition_when_sent_save_on_initial_creation
    company = Company.new :attribute_79 => 'after_create_if_with_symbol_condition'

    assert company.save_without_validation
    assert_equal 'attribute_79', company.attribute_79

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_79
  end

  def test_should_set_its_attribute_80_unless_its_after_create_unless_with_symbol_condition_when_sent_save_on_initial_creation
    company = Company.new :attribute_80 => 'after_create_unless_with_symbol_condition'

    assert company.save_without_validation
    assert_equal 'after_create_unless_with_symbol_condition', company.attribute_80

    company = Company.new

    assert company.save_without_validation
    assert_equal 'attribute_80', company.attribute_80
  end

  def test_should_set_its_attribute_81_if_its_before_save_if_with_symbol_condition_when_sent_save
    company = Company.new :attribute_81 => 'before_save_if_with_symbol_condition'

    assert company.save_without_validation
    assert_equal 'attribute_81', company.attribute_81

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_81

    company.attribute_81 = 'before_save_if_with_symbol_condition'

    assert company.save_without_validation
    assert_equal 'attribute_81', company.attribute_81
  end

  def test_should_set_its_attribute_82_unless_its_before_save_unless_with_symbol_condition_when_sent_save
    company = Company.new :attribute_82 => 'before_save_unless_with_symbol_condition'

    assert company.save_without_validation
    assert_equal 'before_save_unless_with_symbol_condition', company.attribute_82
    assert company.save_without_validation
    assert_equal 'before_save_unless_with_symbol_condition', company.attribute_82

    company = Company.new

    assert company.save_without_validation
    assert_equal 'attribute_82', company.attribute_82

    company.attribute_82 = ''

    assert company.save_without_validation
    assert_equal 'attribute_82', company.attribute_82
  end

  def test_should_set_its_attribute_83_if_its_after_save_if_with_symbol_condition_when_sent_save
    company = Company.new :attribute_83 => 'after_save_if_with_symbol_condition'

    assert company.save_without_validation
    assert_equal 'attribute_83', company.attribute_83

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_83

    company.attribute_83 = 'after_save_if_with_symbol_condition'

    assert company.save_without_validation
    assert_equal 'attribute_83', company.attribute_83
  end

  def test_should_set_its_attribute_84_unless_its_after_save_unless_with_symbol_condition_when_sent_save
    company = Company.new :attribute_84 => 'after_save_unless_with_symbol_condition'

    assert company.save_without_validation
    assert_equal 'after_save_unless_with_symbol_condition', company.attribute_84
    assert company.save_without_validation
    assert_equal 'after_save_unless_with_symbol_condition', company.attribute_84

    company = Company.new

    assert company.save_without_validation
    assert_equal 'attribute_84', company.attribute_84

    company.attribute_84 = ''

    assert company.save_without_validation
    assert_equal 'attribute_84', company.attribute_84
  end

  def test_should_set_its_attribute_85_if_its_before_destroy_if_with_symbol_condition_when_sent_destroy
    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_85

    company.attribute_85 = 'before_destroy_if_with_symbol_condition'
    assert company.destroy
    assert_equal 'attribute_85', company.attribute_85

    company = Company.new

    assert company.save_without_validation
    assert company.destroy
    assert_nil company.attribute_85
  end

  def test_should_set_its_attribute_86_unless_its_before_destroy_unless_with_symbol_condition_when_sent_destroy
    company = Company.new :attribute_86 => 'before_destroy_unless_with_symbol_condition'

    assert company.save_without_validation
    assert company.destroy
    assert_equal 'before_destroy_unless_with_symbol_condition', company.attribute_86

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_86
    assert company.destroy
    assert_equal 'attribute_86', company.attribute_86
  end

  def test_should_set_its_attribute_87_if_its_after_destroy_if_with_symbol_condition_when_sent_destroy
    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_87

    company.attribute_87 = 'after_destroy_if_with_symbol_condition'
    assert company.destroy
    assert_equal 'attribute_87', company.attribute_87

    company = Company.new

    assert company.save_without_validation
    assert company.destroy
    assert_nil company.attribute_87
  end

  def test_should_set_its_attribute_88_unless_its_after_destroy_unless_with_symbol_condition_when_sent_destroy
    company = Company.new :attribute_88 => 'after_destroy_unless_with_symbol_condition'

    assert company.save_without_validation
    assert company.destroy
    assert_equal 'after_destroy_unless_with_symbol_condition', company.attribute_88

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_88
    assert company.destroy
    assert_equal 'attribute_88', company.attribute_88
  end

  def test_should_set_its_attribute_89_if_its_before_update_if_with_symbol_condition_when_sent_save_on_an_update
    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_89

    company.attribute_89 = 'before_update_if_with_symbol_condition'
    assert company.save_without_validation
    assert_equal 'attribute_89', company.attribute_89

    company = Company.new

    assert company.save_without_validation
    assert company.save_without_validation
    assert_nil company.attribute_89
  end

  def test_should_set_its_attribute_90_unless_its_before_update_unless_with_symbol_condition_when_sent_save_on_an_update
    company = Company.new :attribute_90 => 'before_update_unless_with_symbol_condition'

    assert company.save_without_validation
    assert company.save_without_validation
    assert_equal 'before_update_unless_with_symbol_condition', company.attribute_90

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_90
    assert company.save_without_validation
    assert_equal 'attribute_90', company.attribute_90
  end

  def test_should_set_its_attribute_91_if_its_after_update_if_with_symbol_condition_when_sent_save_on_an_update
    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_91

    company.attribute_91 = 'after_update_if_with_symbol_condition'
    assert company.save_without_validation
    assert_equal 'attribute_91', company.attribute_91

    company = Company.new

    assert company.save_without_validation
    assert company.save_without_validation
    assert_nil company.attribute_91
  end

  def test_should_set_its_attribute_92_unless_its_after_update_unless_with_symbol_condition_when_sent_on_an_update
    company = Company.new :attribute_92 => 'after_update_unless_with_symbol_condition'

    assert company.save_without_validation
    assert company.save_without_validation
    assert_equal 'after_update_unless_with_symbol_condition', company.attribute_92

    company = Company.new

    assert company.save_without_validation
    assert_nil company.attribute_92
    assert company.save_without_validation
    assert_equal 'attribute_92', company.attribute_92
  end

  def test_should_set_its_attribute_93_if_its_before_validation_if_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_93 => 'before_validation_if_with_symbol_condition'
    company.valid?
    assert_equal 'attribute_93', company.attribute_93

    company = Company.new
    company.valid?
    assert_nil company.attribute_93
  end

  def test_should_set_its_attribute_94_unless_its_before_validation_unless_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_94 => 'before_validation_unless_with_symbol_condition'
    company.valid?
    assert_equal 'before_validation_unless_with_symbol_condition', company.attribute_94

    company = Company.new
    company.valid?
    assert_equal 'attribute_94', company.attribute_94
  end

  def test_should_set_its_attribute_95_if_its_after_validation_if_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_95 => 'after_validation_if_with_symbol_condition'
    company.valid?
    assert_equal 'attribute_95', company.attribute_95

    company = Company.new
    company.valid?
    assert_nil company.attribute_95
  end

  def test_should_set_its_attribute_96_unless_its_after_validation_unless_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_96 => 'after_validation_unless_with_symbol_condition'
    company.valid?
    assert_equal 'after_validation_unless_with_symbol_condition', company.attribute_96

    company = Company.new
    company.valid?
    assert_equal 'attribute_96', company.attribute_96
  end

  def test_should_set_its_attribute_97_if_its_before_validation_on_create_if_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_97 => 'before_validation_on_create_if_with_symbol_condition'
    company.valid?
    assert_equal 'attribute_97', company.attribute_97

    company = Company.new
    company.valid?
    assert_nil company.attribute_97
  end

  def test_should_set_its_attribute_98_unless_its_before_validation_on_create_unless_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_98 => 'before_validation_on_create_unless_with_symbol_condition'
    company.valid?
    assert_equal 'before_validation_on_create_unless_with_symbol_condition', company.attribute_98

    company = Company.new
    company.valid?
    assert_equal 'attribute_98', company.attribute_98
  end

  def test_should_set_its_attribute_99_if_its_after_validation_on_create_if_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_99 => 'after_validation_on_create_if_with_symbol_condition'
    company.valid?
    assert_equal 'attribute_99', company.attribute_99

    company = Company.new
    company.valid?
    assert_nil company.attribute_99
  end

  def test_should_set_its_attribute_100_unless_its_after_validation_on_create_unless_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_100 => 'after_validation_on_create_unless_with_symbol_condition'
    company.valid?
    assert_equal 'after_validation_on_create_unless_with_symbol_condition', company.attribute_100

    company = Company.new
    company.valid?
    assert_equal 'attribute_100', company.attribute_100
  end

  def test_should_set_its_attribute_101_if_its_before_validation_on_update_if_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_101 => 'before_validation_on_update_if_with_symbol_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_101', company.attribute_101

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_nil company.attribute_101
  end

  def test_should_set_its_attribute_102_unless_its_before_validation_on_update_unless_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_102 => 'before_validation_on_update_unless_with_symbol_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'before_validation_on_update_unless_with_symbol_condition', company.attribute_102

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_102', company.attribute_102
  end

  def test_should_set_its_attribute_103_if_its_after_validation_on_update_if_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_103 => 'after_validation_on_update_if_with_symbol_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_103', company.attribute_103

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_nil company.attribute_103
  end

  def test_should_set_its_attribute_104_unless_its_after_validation_on_update_unless_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_104 => 'after_validation_on_update_unless_with_symbol_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'after_validation_on_update_unless_with_symbol_condition', company.attribute_104

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_104', company.attribute_104
  end

  def test_should_set_its_attribute_105_if_its_after_initialize_if_with_symbol_condition_when_sent_new
    company = Company.new :attribute_105 => 'after_initialize_if_with_symbol_condition'
    assert_equal 'attribute_105', company.attribute_105

    company = Company.new
    assert_nil company.attribute_105
  end

  def test_should_set_its_attribute_106_unless_its_after_initialize_unless_with_symbol_condition_when_sent_new
    company = Company.new :attribute_106 => 'after_initialize_unless_with_symbol_condition'
    assert_equal 'after_initialize_unless_with_symbol_condition', company.attribute_106

    company = Company.new
    assert_equal 'attribute_106', company.attribute_106
  end

  def test_should_set_its_attribute_107_if_its_name_is_after_find_if_with_symbol_condition_when_sent_find
    company = Company.new :name => 'after_find_if_with_symbol_condition'
    assert company.save

    company = Company.find company.id
    assert_equal 'attribute_107', company.attribute_107
  end

  def test_should_set_its_attribute_108_unless_its_name_is_after_find_unless_with_symbol_condition_when_sent_find
    company = Company.new :name => 'after_find_unless_with_symbol_condition'
    assert company.save

    company = Company.find company.id
    assert_nil company.attribute_108

    company = Company.new :name => 'name'
    assert company.save

    company = Company.find company.id
    assert_equal 'attribute_108', company.attribute_108
  end

  def test_should_set_its_attribute_109_if_its_validate_if_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_109 => 'validate_if_with_symbol_condition'
    company.valid?
    assert_equal 'attribute_109', company.attribute_109

    company = Company.new
    company.valid?
    assert_nil company.attribute_109
  end

  def test_should_set_its_attribute_110_unless_its_validate_unless_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_110 => 'validate_unless_with_symbol_condition'
    company.valid?
    assert_equal 'validate_unless_with_symbol_condition', company.attribute_110

    company = Company.new
    company.valid?
    assert_equal 'attribute_110', company.attribute_110
  end

  def test_should_set_its_attribute_111_if_its_validate_on_create_if_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_111 => 'validate_on_create_if_with_symbol_condition'
    company.valid?
    assert_equal 'attribute_111', company.attribute_111

    company = Company.new
    company.valid?
    assert_nil company.attribute_111
  end

  def test_should_set_its_attribute_112_unless_its_validate_on_create_unless_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_112 => 'validate_on_create_unless_with_symbol_condition'
    company.valid?
    assert_equal 'validate_on_create_unless_with_symbol_condition', company.attribute_112

    company = Company.new
    company.valid?
    assert_equal 'attribute_112', company.attribute_112
  end

  def test_should_set_its_attribute_113_if_its_validate_on_update_if_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_113 => 'validate_on_update_if_with_symbol_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_113', company.attribute_113

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_nil company.attribute_113
  end

  def test_should_set_its_attribute_114_unless_its_validate_on_update_unless_with_symbol_condition_when_sent_valid?
    company = Company.new :attribute_114 => 'validate_on_update_unless_with_symbol_condition'
    assert company.save_without_validation
    company.valid?
    assert_equal 'validate_on_update_unless_with_symbol_condition', company.attribute_114

    company = Company.new
    assert company.save_without_validation
    company.valid?
    assert_equal 'attribute_114', company.attribute_114
  end

end
