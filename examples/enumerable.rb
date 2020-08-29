# frozen_string_literal: true

require_relative "../lib/progress_bar/core_ext/enumerable_with_progress"

(20...34).with_progress.select{ |i| sleep 0.1; (i % 2).zero? }
