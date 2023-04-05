#' Get multiple portfolio memberships
#'
#' Returns a list of portfolio memberships in compact representation. You must specify `portfolio`, `portfolio` and `user`, or `workspace` and `user`.
#'
#' @param limit (optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.
#' @param offset (optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#' @param portfolio (optional) (character scalar) The portfolio to filter results on.
#' @param user (optional) (character scalar) A string identifying a user. This can either be the string "me", an email, or the gid of a user.
#' @param workspace (optional) (character scalar) The workspace to filter results on.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_portfolio_memberships <- function(limit, offset, opt_fields, portfolio, user, workspace) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/portfolio_memberships"),
    query = list(limit = limit, offset = offset, opt_fields = opt_fields, portfolio = portfolio, user = user, workspace = workspace),
    method = "get"
  )
}


#' Get a portfolio membership
#'
#' Returns the complete portfolio record for a single portfolio membership.
#'
#' @param portfolio_membership_gid (character scalar) NA
#' @param opt_fields (optional) (character vector) Defines fields to return. Some requests return *compact* representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.
#'
#' @return A generic Asana Resource, containing a globally unique identifier.
#'
#' @keywords internal
asn_get_portfolio_membership <- function(portfolio_membership_gid, opt_fields) {
  # Confirm that this makes sense. If so, change
  # @keywords internal to @export.
  .call_api(
    endpoint = list("/portfolio_memberships/{portfolio_membership_gid}", portfolio_membership_gid = portfolio_membership_gid),
    query = list(opt_fields = opt_fields),
    method = "get"
  )
}
