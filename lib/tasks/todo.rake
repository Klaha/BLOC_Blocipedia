namespace :todo do
  desc "Downgrade premium accounts after 30 days"
  task downgrade_accounts: :environment do
    p "#{User.where('premium <= ?', Time.now - 30.days).count} users downgraded"
    User.where("premium <= ?", Time.now - 30.days).update_all(role: 'standard', premium: nil)
  end

end
