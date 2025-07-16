class QuestionnaireLoader
  SCHEMA = JSON.parse(File.read(Rails.root.join('config/schema/questionnaire.json')))

  def self.load(id)
    path = Rails.root.join('config/questionnaires', "#{id}.yaml")
    raise "YAML not found for \#{id}" unless File.exist?(path)
    data = YAML.load_file(path)
    begin
      JSON::Validator.validate!(SCHEMA, data)
    rescue JSON::Schema::SchemaError => e
      Rails.logger.warn "Schema validation skipped: \#{e.message}"
    end
    data
  end
end
