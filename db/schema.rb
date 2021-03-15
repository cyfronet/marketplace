# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_02_061137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "ancestry_depth", default: 0
    t.string "eid"
    t.index ["ancestry"], name: "index_categories_on_ancestry"
    t.index ["description"], name: "index_categories_on_description"
    t.index ["name", "ancestry"], name: "index_categories_on_name_and_ancestry", unique: true
  end

  create_table "categorizations", force: :cascade do |t|
    t.bigint "service_id"
    t.bigint "category_id"
    t.boolean "main", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categorizations_on_category_id"
    t.index ["service_id"], name: "index_categorizations_on_service_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.string "phone"
    t.string "position"
    t.string "organisation"
    t.string "contactable_type"
    t.string "type"
    t.bigint "contactable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contactable_id"], name: "index_contacts_on_contactable_id"
    t.index ["id", "contactable_id", "contactable_type"], name: "index_contacts_on_id_and_contactable_id_and_contactable_type", unique: true
  end

  create_table "data_administrators", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_data_administrators_on_email"
    t.index ["first_name"], name: "index_data_administrators_on_first_name"
    t.index ["last_name"], name: "index_data_administrators_on_last_name"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "help_items", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug"
    t.integer "position", default: 0, null: false
    t.bigint "help_section_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["help_section_id"], name: "index_help_items_on_help_section_id"
  end

  create_table "help_sections", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lead_sections", force: :cascade do |t|
    t.string "slug", null: false
    t.string "title", null: false
    t.string "template", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "leads", force: :cascade do |t|
    t.string "header", null: false
    t.string "body", null: false
    t.string "url", null: false
    t.bigint "lead_section_id", null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lead_section_id"], name: "index_leads_on_lead_section_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "author_id"
    t.text "message"
    t.integer "iid"
    t.string "messageable_type"
    t.bigint "messageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "edited", default: false
    t.index ["author_id"], name: "index_messages_on_author_id"
    t.index ["messageable_type", "messageable_id"], name: "index_messages_on_messageable_type_and_messageable_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "iid", null: false
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "parameters", default: [], null: false
    t.boolean "voucherable", default: false, null: false
    t.string "status"
    t.string "order_type", null: false
    t.string "webpage"
    t.boolean "internal", default: false
    t.string "order_url"
    t.boolean "default", default: false
    t.index ["iid"], name: "index_offers_on_iid"
    t.index ["service_id", "iid"], name: "index_offers_on_service_id_and_iid", unique: true
    t.index ["service_id"], name: "index_offers_on_service_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "eid"
    t.index ["name"], name: "index_platforms_on_name", unique: true
  end

  create_table "project_item_changes", force: :cascade do |t|
    t.string "status"
    t.text "message"
    t.bigint "project_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id"
    t.integer "iid"
    t.index ["author_id"], name: "index_project_item_changes_on_author_id"
    t.index ["project_item_id"], name: "index_project_item_changes_on_project_item_id"
  end

  create_table "project_items", force: :cascade do |t|
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "issue_id"
    t.integer "issue_status", default: 2, null: false
    t.bigint "project_id"
    t.bigint "offer_id"
    t.jsonb "properties", default: [], null: false
    t.boolean "request_voucher", default: false, null: false
    t.string "voucher_id", default: "", null: false
    t.integer "iid"
    t.string "name", null: false
    t.text "description", null: false
    t.string "order_type", null: false
    t.string "webpage"
    t.boolean "voucherable", default: false, null: false
    t.boolean "internal", default: false
    t.string "order_url"
    t.index ["offer_id"], name: "index_project_items_on_offer_id"
    t.index ["project_id"], name: "index_project_items_on_project_id"
  end

  create_table "project_scientific_domains", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "scientific_domain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "scientific_domain_id"], name: "index_psd_on_service_id_and_sd_id", unique: true
    t.index ["project_id"], name: "index_project_scientific_domains_on_project_id"
    t.index ["scientific_domain_id"], name: "index_project_scientific_domains_on_scientific_domain_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.text "reason_for_access"
    t.string "customer_typology"
    t.string "user_group_name"
    t.string "project_name"
    t.string "project_website_url"
    t.string "company_name"
    t.string "company_website_url"
    t.string "country_of_origin"
    t.string "countries_of_partnership", default: [], array: true
    t.integer "issue_id"
    t.integer "issue_status", default: 2, null: false
    t.string "issue_key"
    t.text "additional_information"
    t.string "email"
    t.string "organization"
    t.string "department"
    t.string "webpage"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "user_id"], name: "index_projects_on_name_and_user_id", unique: true
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "provider_data_administrators", force: :cascade do |t|
    t.bigint "data_administrator_id"
    t.bigint "provider_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["data_administrator_id"], name: "index_provider_data_administrators_on_data_administrator_id"
    t.index ["provider_id"], name: "index_provider_data_administrators_on_provider_id"
  end

  create_table "provider_scientific_domains", force: :cascade do |t|
    t.bigint "provider_id"
    t.bigint "scientific_domain_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider_id", "scientific_domain_id"], name: "index_psd_on_provider_id_and_sd_id", unique: true
    t.index ["provider_id"], name: "index_provider_scientific_domains_on_provider_id"
    t.index ["scientific_domain_id"], name: "index_provider_scientific_domains_on_scientific_domain_id"
  end

  create_table "provider_sources", force: :cascade do |t|
    t.string "eid", null: false
    t.string "source_type", null: false
    t.bigint "provider_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["eid", "source_type", "provider_id"], name: "index_provider_sources_on_eid_and_source_type_and_provider_id", unique: true
    t.index ["provider_id"], name: "index_provider_sources_on_provider_id"
  end

  create_table "provider_vocabularies", force: :cascade do |t|
    t.bigint "provider_id"
    t.bigint "vocabulary_id"
    t.string "vocabulary_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider_id", "vocabulary_id"], name: "index_provider_vocabularies_on_provider_id_and_vocabulary_id", unique: true
    t.index ["provider_id"], name: "index_provider_vocabularies_on_provider_id"
    t.index ["vocabulary_id"], name: "index_provider_vocabularies_on_vocabulary_id"
  end

  create_table "providers", force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pid"
    t.string "abbreviation"
    t.string "website"
    t.boolean "legal_entity"
    t.text "description"
    t.string "multimedia", default: [], array: true
    t.text "tagline"
    t.string "street_name_and_number"
    t.string "postal_code"
    t.string "city"
    t.string "region"
    t.string "country"
    t.string "certifications", default: [], array: true
    t.string "hosting_legal_entity"
    t.string "participating_countries", default: [], array: true
    t.string "affiliations", default: [], array: true
    t.string "national_roadmaps", default: [], array: true
    t.integer "upstream_id"
    t.datetime "synchronized_at"
    t.index ["name"], name: "index_providers_on_name", unique: true
  end

  create_table "scientific_domains", force: :cascade do |t|
    t.text "name", null: false
    t.string "ancestry"
    t.integer "ancestry_depth", default: 0
    t.string "eid"
    t.text "description"
    t.index ["name", "ancestry"], name: "index_scientific_domains_on_name_and_ancestry", unique: true
  end

  create_table "service_opinions", force: :cascade do |t|
    t.integer "service_rating", null: false
    t.text "opinion"
    t.bigint "project_item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_rating", null: false
    t.index ["project_item_id"], name: "index_service_opinions_on_project_item_id"
  end

  create_table "service_providers", force: :cascade do |t|
    t.bigint "service_id"
    t.bigint "provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_id"], name: "index_service_providers_on_provider_id"
    t.index ["service_id", "provider_id"], name: "index_service_providers_on_service_id_and_provider_id", unique: true
    t.index ["service_id"], name: "index_service_providers_on_service_id"
  end

  create_table "service_related_platforms", force: :cascade do |t|
    t.bigint "service_id"
    t.bigint "platform_id"
    t.index ["platform_id"], name: "index_service_related_platforms_on_platform_id"
    t.index ["service_id", "platform_id"], name: "index_service_related_platforms_on_service_id_and_platform_id", unique: true
    t.index ["service_id"], name: "index_service_related_platforms_on_service_id"
  end

  create_table "service_relationships", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.bigint "target_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["source_id", "target_id", "type"], name: "index_service_relationships_on_source_id_and_target_id_and_type", unique: true
    t.index ["source_id"], name: "index_service_relationships_on_source_id"
    t.index ["target_id"], name: "index_service_relationships_on_target_id"
  end

  create_table "service_scientific_domains", force: :cascade do |t|
    t.bigint "service_id"
    t.bigint "scientific_domain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scientific_domain_id"], name: "index_service_scientific_domains_on_scientific_domain_id"
    t.index ["service_id", "scientific_domain_id"], name: "index_ssd_on_service_id_and_sd_id", unique: true
    t.index ["service_id"], name: "index_service_scientific_domains_on_service_id"
  end

  create_table "service_sources", force: :cascade do |t|
    t.string "eid", null: false
    t.string "source_type", null: false
    t.bigint "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["eid", "source_type", "service_id"], name: "index_service_sources_on_eid_and_source_type_and_service_id", unique: true
    t.index ["service_id"], name: "index_service_sources_on_service_id"
  end

  create_table "service_target_users", force: :cascade do |t|
    t.bigint "service_id"
    t.bigint "target_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id", "target_user_id"], name: "index_service_target_users_on_service_id_and_target_user_id", unique: true
    t.index ["service_id"], name: "index_service_target_users_on_service_id"
    t.index ["target_user_id"], name: "index_service_target_users_on_target_user_id"
  end

  create_table "service_user_relationships", force: :cascade do |t|
    t.bigint "service_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_service_user_relationships_on_service_id"
    t.index ["user_id"], name: "index_service_user_relationships_on_user_id"
  end

  create_table "service_vocabularies", force: :cascade do |t|
    t.bigint "service_id"
    t.bigint "vocabulary_id"
    t.string "vocabulary_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_id", "vocabulary_id"], name: "index_service_vocabularies_on_service_id_and_vocabulary_id", unique: true
    t.index ["service_id"], name: "index_service_vocabularies_on_service_id"
    t.index ["vocabulary_id"], name: "index_service_vocabularies_on_vocabulary_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "tagline", null: false
    t.decimal "rating", precision: 2, scale: 1, default: "0.0", null: false
    t.bigint "provider_id"
    t.integer "service_opinion_count", default: 0
    t.string "geographical_availabilities", default: [], array: true
    t.string "language_availability", default: [], array: true
    t.string "dedicated_for", array: true
    t.string "terms_of_use_url"
    t.string "access_policies_url"
    t.string "sla_url"
    t.string "webpage_url"
    t.string "manual_url"
    t.string "helpdesk_url"
    t.string "training_information_url"
    t.string "restrictions"
    t.integer "offers_count", default: 0
    t.text "activate_message"
    t.string "slug"
    t.string "order_type"
    t.string "status"
    t.integer "upstream_id"
    t.string "order_target", default: "", null: false
    t.string "helpdesk_email", default: ""
    t.integer "project_items_count", default: 0, null: false
    t.string "version"
    t.float "popularity_ratio"
    t.bigint "resource_organisation_id"
    t.string "status_monitoring_url"
    t.string "maintenance_url"
    t.string "order_url"
    t.string "payment_model_url"
    t.string "pricing_url"
    t.string "security_contact_email", default: "", null: false
    t.string "resource_geographic_locations", default: [], array: true
    t.string "certifications", default: [], array: true
    t.string "standards", default: [], array: true
    t.string "open_source_technologies", default: [], array: true
    t.text "changelog", default: [], array: true
    t.string "grant_project_names", default: [], array: true
    t.string "multimedia", default: [], array: true
    t.string "privacy_policy_url"
    t.string "use_cases_url", default: [], array: true
    t.datetime "last_update"
    t.string "related_platforms", default: [], array: true
    t.datetime "synchronized_at"
    t.string "pid"
    t.index ["name"], name: "index_services_on_name"
    t.index ["provider_id"], name: "index_services_on_provider_id"
    t.index ["resource_organisation_id"], name: "index_services_on_resource_organisation_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.bigint "author_id"
    t.string "status"
    t.string "status_holder_type"
    t.bigint "status_holder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_statuses_on_author_id"
    t.index ["status_holder_type", "status_holder_id"], name: "index_statuses_on_status_holder_type_and_status_holder_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "target_users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.text "eid"
  end

  create_table "tour_feedbacks", force: :cascade do |t|
    t.string "controller_name"
    t.string "action_name"
    t.string "tour_name"
    t.bigint "user_id"
    t.string "email"
    t.json "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["action_name"], name: "index_tour_feedbacks_on_action_name"
    t.index ["controller_name"], name: "index_tour_feedbacks_on_controller_name"
    t.index ["email"], name: "index_tour_feedbacks_on_email"
    t.index ["tour_name"], name: "index_tour_feedbacks_on_tour_name"
    t.index ["user_id"], name: "index_tour_feedbacks_on_user_id"
  end

  create_table "tour_histories", force: :cascade do |t|
    t.string "controller_name"
    t.string "action_name"
    t.string "tour_name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at"], name: "index_tour_histories_on_created_at"
    t.index ["updated_at"], name: "index_tour_histories_on_updated_at"
    t.index ["user_id"], name: "index_tour_histories_on_user_id"
  end

  create_table "user_categories", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_user_categories_on_category_id"
    t.index ["user_id", "category_id"], name: "index_user_categories_on_user_id_and_category_id", unique: true
    t.index ["user_id"], name: "index_user_categories_on_user_id"
  end

  create_table "user_scientific_domains", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "scientific_domain_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["scientific_domain_id"], name: "index_user_scientific_domains_on_scientific_domain_id"
    t.index ["user_id", "scientific_domain_id"], name: "index_usd_on_service_id_and_sd_id", unique: true
    t.index ["user_id"], name: "index_user_scientific_domains_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "roles_mask"
    t.integer "owned_services_count", default: 0, null: false
    t.boolean "categories_updates", default: false, null: false
    t.boolean "scientific_domains_updates", default: false, null: false
    t.boolean "show_welcome_popup", default: false, null: false
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email"
  end

  create_table "vocabularies", force: :cascade do |t|
    t.string "eid", null: false
    t.string "name", null: false
    t.text "description"
    t.string "type", null: false
    t.string "ancestry"
    t.integer "ancestry_depth", default: 0
    t.jsonb "extras"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ancestry"], name: "index_vocabularies_on_ancestry"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "project_item_changes", "users", column: "author_id"
  add_foreign_key "project_items", "offers"
  add_foreign_key "project_items", "projects"
  add_foreign_key "project_scientific_domains", "projects"
  add_foreign_key "project_scientific_domains", "scientific_domains"
  add_foreign_key "provider_scientific_domains", "providers"
  add_foreign_key "provider_scientific_domains", "scientific_domains"
  add_foreign_key "provider_vocabularies", "providers"
  add_foreign_key "provider_vocabularies", "vocabularies"
  add_foreign_key "service_providers", "providers"
  add_foreign_key "service_providers", "services"
  add_foreign_key "service_related_platforms", "platforms"
  add_foreign_key "service_related_platforms", "services"
  add_foreign_key "service_relationships", "services", column: "source_id"
  add_foreign_key "service_relationships", "services", column: "target_id"
  add_foreign_key "service_scientific_domains", "scientific_domains"
  add_foreign_key "service_scientific_domains", "services"
  add_foreign_key "service_target_users", "services"
  add_foreign_key "service_target_users", "target_users"
  add_foreign_key "service_user_relationships", "services"
  add_foreign_key "service_user_relationships", "users"
  add_foreign_key "service_vocabularies", "services"
  add_foreign_key "service_vocabularies", "vocabularies"
  add_foreign_key "services", "providers"
  add_foreign_key "services", "providers", column: "resource_organisation_id"
  add_foreign_key "services", "service_sources", column: "upstream_id", on_delete: :nullify
  add_foreign_key "tour_feedbacks", "users"
  add_foreign_key "tour_histories", "users"
  add_foreign_key "user_categories", "categories"
  add_foreign_key "user_categories", "users"
  add_foreign_key "user_scientific_domains", "scientific_domains"
  add_foreign_key "user_scientific_domains", "users"
end
