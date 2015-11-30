# default cron env is "/usr/bin:/bin" which is not sufficient as govuk_env is in /usr/local/bin
env :PATH, '/usr/local/bin:/usr/bin:/bin'

# We need Rake to use our own environment
job_type :rake, "cd :path && govuk_setenv whitehall bundle exec rake :task --silent :output"

every :day, at: ['3am', '12:45pm'], roles: [:admin] do
  rake "export:mappings"
end

every :day, at: ['1:30am'], roles: [:backend] do
  rake "rummager:index:closed_consultations"
end
