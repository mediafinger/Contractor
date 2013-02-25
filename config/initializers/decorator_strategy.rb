# To use Draper together with decent_exposure
# https://github.com/voxdolo/decent_exposure/wiki/Strategies%3A-Draper-(Decorator)-implementation
class DecoratorStrategy < DecentExposure::ActiveRecordWithEagerAttributesStrategy

  def resource
    r = super.tap { |r| r.class.send(:include, Draper::Decoratable) }
    r.decorate
  end
end
