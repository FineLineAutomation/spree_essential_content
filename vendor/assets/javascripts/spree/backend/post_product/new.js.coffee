($ '#cancel_link').click (event) ->
  event.preventDefault()

  ($ '.no-objects-found').show()

  ($ '#new_related_product_link').show()
  ($ '#related_products').html('')

$(document).ready ->
  $('[data-hook="post_product_variant"]').find(".variant_autocomplete").variantAutocomplete()
  return