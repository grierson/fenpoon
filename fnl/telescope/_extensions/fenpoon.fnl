(local telescope (require :telescope))
(local api (require :fenpoon.api))

(telescope.register_extension {:exports {:fenpoon api.telescope}})
