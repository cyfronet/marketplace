# frozen_string_literal: true

class ArrayInput < SimpleForm::Inputs::TextInput
  def input(wrapper_options)
    input_html_options[:type] ||= input_type
    existing_values = Array(object.public_send(attribute_name))
    existing_values.push(nil)

    template.content_tag(:div) do
      existing_values.map.with_index do |array_el, index|
        element_id = "#{object_name}_#{attribute_name}_#{index}"
        element_name = "#{object_name}[#{attribute_name}][]"

        template.concat add_field(element_id, element_name, array_el)
      end
    end
  end

  def add_field(element_id, element_name, value)
    template.content_tag(:div, id: "#{element_id}_wrapper") do
      template.concat @builder.text_area(nil, input_html_options.merge(value: value,
                                              name: element_name,
                                              id: element_id))
      template.concat remove_icon("#{element_id}_wrapper")
    end
  end

  def remove_icon(id)
    template.content_tag(:span) do
      template.concat remove_icon(id)
    end
  end

  def remove_icon(id)
    "<a class='text-primary' data-action='click->service#removeArrayField' data-class='form-control text optional' data-name='#{id}'>Remove field</a>".html_safe
  end

  def input_type
    :text
  end
end
