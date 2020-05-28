class StaticPageService
  def initialize(user)
    @user = user
    @data = data
  end

  def create(attribute)
    record.assign_attributes(attribute)
    record.save!
  end

  def update(attribute)
    record.assign_attributes(attribute)
    record.save!
  end

  def destroy
    record.destroy!
  end

  private

  attr_accessor :user, :data

  def record
    channel
  end
end
