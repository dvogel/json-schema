require File.expand_path('../test_helper', __FILE__)

class AdditionalPropertiesTest < Minitest::Test

  TestSchema = {
    'type' => 'object',
    'properties' => {
      'prop_1' => { 'type' => 'string' },
      'prop_2' => { 'type' => 'string' }
    },
    'additionalProperties' => false
  }

  def test_property_subset_1
    value_to_validate = {
      'prop_1' => 'xxx'
    }
    errors = JSON::Validator.fully_validate(TestSchema, value_to_validate)
    assert_equal errors.length, 0
  end

  def test_property_subset_2
    value_to_validate = {
      'prop_2' => 'xxx'
    }
    errors = JSON::Validator.fully_validate(TestSchema, value_to_validate)
    assert_equal errors.length, 0
  end

  def test_spurious_property
    value_to_validate = {
      'prop_x' => 'xxx'
    }
    errors = JSON::Validator.fully_validate(TestSchema, value_to_validate)
    assert_equal errors.length, 1
  end

  def test_spurious_property_alongside_required
    value_to_validate = {
      'prop_x' => 'xxx'
    }
    schema = TestSchema.dup.merge(
      'required' => ['prop_1']
    )
    errors = JSON::Validator.fully_validate(schema, value_to_validate)
    assert_equal errors.length, 1
  end

end

