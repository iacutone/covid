alias Covid.Batteries
alias Covid.Companies
alias Covid.Questionnaires
alias Covid.Questions
alias Covid.Users
alias Covid.Workers

user_params = %{
  "email" => "test@test.com",
  "password" => "password",
  "password_confirmation" => "password"
}

{:ok, user} = Users.create_user(user_params)

{:ok, company} = Companies.create_company(%{
  name: "Empire Precision",
  user_id: user.id
})

Workers.create_worker(%{
  name: "Joe Smith",
  company_id: company.id
}) 

user_params = %{
  "email" => "eric.iacutone@gmail.com",
  "password" => "password",
  "password_confirmation" => "password"
}

{:ok, user_2} = Users.create_user(user_params)

{:ok, company_2} = Companies.create_company(%{
  name: "Test Co",
  user_id: user_2.id 
})

{:ok, worker} = Workers.create_worker(%{
  name: "Test Worker",
  company_id: company_2.id
}) 

Questions.create_question(%{
  active: true,
  query: "Is your temperature above 100 degrees F?"
})

Questions.create_question(%{
  active: true,
  query: "Are you experiencing a sore throat?"
})

Questions.create_question(%{
  active: true,
  query: "Are you experiencing a cough?"
})

Questions.create_question(%{
  active: false,
  query: "Not an active question"
})

{:ok, question} = Questions.create_question(%{
  active: true,
  query: "Are you experiencing any shortness of breath?"
})

{:ok, questionnaire} = Questionnaires.create_questionnaire(%{
  worker_id: worker.id,
  company_id: company_2.id
})

Batteries.create_battery(%{
  question_id: question.id,
  questionnaire_id: questionnaire.id
})
