# Add explicit metadata fields to templates_checklists, loosely based on a subset of properties in the
# /elements/1.1/ namespace of the Dublin Core Metadata Initiative (DCMI) metadata terms.
#
# See https://www.dublincore.org/specifications/dublin-core/dcmi-terms/) for details
#
# Metadata fields are optional and can be used to provide additional information about a checklist template.
class AddMetadataFieldsToTemplatesChecklists < ActiveRecord::Migration[7.1]
  def change
    remove_column :templates_checklists, :metadata, :jsonb

    add_column :templates_checklists, :contributor, :string
    add_column :templates_checklists, :creator, :string
    add_column :templates_checklists, :description, :string
    add_column :templates_checklists, :format, :string, default: 'text/markdown'
    add_column :templates_checklists, :language, :string, default: 'en'
    add_column :templates_checklists, :publisher, :string
    add_column :templates_checklists, :rights, :string
    add_column :templates_checklists, :source, :string
    add_column :templates_checklists, :title_alternative, :string
  end
end
