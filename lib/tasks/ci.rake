# frozen_string_literal: true

namespace :ci do
  task all: ["ci:test", "rspec"]
end