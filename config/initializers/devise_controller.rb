# DeviseController.class_eval do
#   def resource_params
#     unless params[resource_name].blank?
#       params.require(resource_name).permit(:email, :name)
#     end
#   end
# end
