defmodule Changelog.NewsSource do
  use Changelog.Data

  alias Changelog.{Icon, NewsItem, Regexp}

  schema "news_sources" do
    field :name, :string
    field :slug, :string
    field :website, :string
    field :regex, :string

    field :icon, Icon.Type

    has_many :news_items, NewsItem, on_delete: :nilify_all

    timestamps()
  end

  def admin_changeset(news_source, attrs \\ %{}) do
    news_source
    |> cast_attachments(attrs, ~w(icon))
    |> cast(attrs, ~w(name slug website regex icon))
    |> validate_required([:name, :slug, :website])
    |> validate_format(:website, Regexp.http, message: Regexp.http_message)
    |> unique_constraint(:slug)
  end
end