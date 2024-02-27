# class SandboxEmailInterceptor
#   def self.delivering_email(message)
#     message.to = ['sandbox@obsekio.com']
#   end
# end

# Rails.application.configure do
#   if Rails.env.test?
#     config.action_mailer.interceptors = %w[SandboxEmailInterceptor]
#   end
# end
