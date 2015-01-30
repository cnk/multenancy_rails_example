Warden::Strategies.add(:password) do
  def valid?
    host = request.host
    subdomain = ActionDispatch::Http::URL.extract_subdomains(host, 1)
    subdomain.present? && params["user"]
  end

  def authenticate!
    if u = Subscribem::User.where(email: params["user"]["email"]).first
      u.authenticate(params["user"]["password"]) ? success!(u) : fail!
    else
      fail!
    end
  end
end
