# TODO if env = development

require 'letter_opener'

ActionMailer::Base.add_delivery_method :letter_opener, LetterOpener::DeliveryMethod, :location => Rails.root.join("tmp", "letter_opener")