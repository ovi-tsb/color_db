require "administrate/base_dashboard"

class CustomerUserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number.with_options(searchable: false),
    email: Field::String.with_options(searchable: true),
    encrypted_password: Field::String.with_options(searchable: false),
    reset_password_token: Field::String.with_options(searchable: false),
    reset_password_sent_at: Field::DateTime.with_options(searchable: false),
    remember_created_at: Field::DateTime.with_options(searchable: false),
    first_name: Field::String.with_options(searchable: true),
    last_name: Field::String.with_options(searchable: true),
    type: Field::String.with_options(searchable: false),
    created_at: Field::DateTime.with_options(searchable: false),
    updated_at: Field::DateTime.with_options(searchable: false),
    password: Field::String.with_options(searchable: false),
    password_confirmation: Field::String.with_options(searchable: false),
    customer_name: Field::String.with_options(searchable: true),
    customer_id: Field::String.with_options(searchable: true),
    # customer_name: Field::Select.with_options(Customer.all, :id, :name, {:prompt => '-- Select a Customer --'})
    
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  id
  email
  customer_id
  first_name
  last_name
  encrypted_password
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  id
  email
  encrypted_password
  reset_password_token
  reset_password_sent_at
  remember_created_at
  first_name
  last_name
  type
  customer_name
  customer_id
  created_at
  updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  email
  password
  password_confirmation
  remember_created_at
  first_name
  last_name
  type
  customer_name
  customer_id
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how customer users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(customer_user)
  #   "CustomerUser ##{customer_user.id}"
  # end
end
