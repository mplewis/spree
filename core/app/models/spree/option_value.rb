module Spree
  class OptionValue < Spree::Base
    belongs_to :option_type, class_name: 'Spree::OptionType', touch: true, inverse_of: :option_values
    acts_as_list scope: :option_type

    has_many :option_value_variants, class_name: 'Spree::OptionValueVariant'
    has_many :variants, through: :option_value_variants, class_name: 'Spree::Variant'

    validates :name, presence: true, uniqueness: { scope: :option_type_id, allow_blank: true }
    validates :presentation, presence: true

    after_touch :touch_all_variants

    self.whitelisted_ransackable_attributes = ['presentation']

    def touch_all_variants
      variants.update_all(updated_at: Time.current)
    end
  end
end
