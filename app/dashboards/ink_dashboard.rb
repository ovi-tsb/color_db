require "administrate/base_dashboard"

class InkDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number.with_options(searchable: true),
    name: Field::String.with_options(searchable: true),
    client: Field::String.with_options(searchable: true),
    ink_type: Field::String.with_options(searchable: true),
    substrate: Field::String.with_options(searchable: false),
    coating: Field::String.with_options(searchable: false),
    ink_number: Field::String.with_options(searchable: true),
    sap: Field::String.with_options(searchable: true),
    approved: Field::Boolean.with_options(searchable: false),
    created_at: Field::DateTime.with_options(searchable: false),
    updated_at: Field::DateTime.with_options(searchable: false),
    comments: Field::String.with_options(searchable: false),
    approved_on: Field::String.with_options(searchable: false),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  id
  name
  ink_number
  sap
  client
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  id
  name
  client
  ink_type
  substrate
  coating
  ink_number
  sap
  approved
  created_at
  updated_at
  comments
  approved_on
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  name
  client
  ink_type
  substrate
  coating
  ink_number
  sap
  approved
  comments
  approved_on
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

  # Overwrite this method to customize how inks are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(ink)
  #   "Ink ##{ink.id}"
  # end
end
