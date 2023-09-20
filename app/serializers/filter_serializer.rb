class FilterSerializer < ActiveModel::Serializer
    attributes :id, :name, :column_name, :filter_type, :values
  end