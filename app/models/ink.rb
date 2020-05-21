class Ink < ApplicationRecord

  belongs_to :customer, required: false
  belongs_to :user, required: false

  before_update :update_modified_by
  

  filterrific(
     default_filter_params: { sorted_by: 'created_at_desc' },
     available_filters: [
        :sorted_by,
        :search_query,
        :with_created_at,
        :with_name,
        :with_client,
        :with_customer_id
     ]
   )




  ###### filteriffic 
  self.per_page = 5000
  ########  searching
  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.to_s.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      ('%' + e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 6
    where(
      terms.map {
        or_clauses = [
          "LOWER(inks.name) LIKE ?",
          "LOWER(inks.client) LIKE ?",
          "LOWER(inks.ink_number) LIKE ?",
          "LOWER(inks.client) LIKE ?",
          "LOWER(inks.coating) LIKE ?",
          "LOWER(inks.sap) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }
  
  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("inks.created_at #{ direction }")
    when /^client_/
      order("inks.client #{ direction }")
    when /^name_/
      order("inks.name #{ direction }")
    when /^customer_id_/
      order("inks.customer_id #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
  
  scope :with_client, lambda { |client|
      where(:client => [*client])
    }
  scope :with_name, lambda { |name|
      where(:name => [*name])
    }
  scope :with_created_at, lambda { |ref_date|
    where('inks.created_at::date = ?', ref_date)
  }
  # scope :with_date, lambda { |ref_date|
  #   where('jobs.date::date = ?', ref_date)
  # }
  # scope :with_customer_id, lambda { |customer_id|
  #   where(:customer_id => [*customer_id]) }

  # scope :with_customer_id, lambda { |customer_id|
  #   where(@ink.customer_id = Customer.id).joins(:customer)
  # }
  scope :with_customer_id, lambda { |customer_ids|
    where(:customer_id => [*customer_ids])
  }

  delegate :name, :to => :customer, :prefix => true

  def self.options_for_sorted_by
    [
      ['Newest first', 'created_at_desc'],
      ['Oldest first', 'created_at_asc'],
      ['PMS (Asc)', 'name_asc'],
      ['PMS (Desc)', 'name_desc'],
      ['Cust (Desc)', 'customer_id_desc'],
      ['Cust (asc)', 'customer_id_asc']
    ]
  end

  def self.options_for_select
    
      Customer.pluck(:name, :id).each do |customer|
        [
          customer,
        ]
      end
    # [
    #       ['Ellis Guelph', 1],
    #       ['Royal Anvelope', 2],
    #       ['Ellis Mississauga', 3]
    # ]
    # order('LOWER(customer_name)').map { |e| [e.customer_name, e.id] }    
  end


  def decorated_created_at
    created_at.to_date.to_s(:long)
  end
  
  
  # filteriffic 

  def update_modified_by
    self.modified_by = current_user_name 
  end
  def current_user_name
    User.current_user.first_name + " " + User.current_user.last_name[0].upcase + "." 
  end

end
