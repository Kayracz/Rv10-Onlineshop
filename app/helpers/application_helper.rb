module ApplicationHelper
  include Pagy::Frontend

def number_to_currency_bo(number)
  number_to_currency(number, :unit => "Bs. ", :separator => ".", :delimiter => ",")
end

end
