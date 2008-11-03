module Admin::SettingsHelper
  def settings_field(setting)
    if setting
      render :partial => "#{setting.field_type}", :locals => {:setting => setting}
    else
      "No setting."
    end
  end
end
