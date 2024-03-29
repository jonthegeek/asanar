% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/projects.R
\name{asn_get_custom_field_settings_for_project}
\alias{asn_get_custom_field_settings_for_project}
\title{Get a project's custom fields}
\usage{
asn_get_custom_field_settings_for_project(
  project_gid,
  limit,
  offset,
  opt_fields
)
}
\arguments{
\item{project_gid}{(character scalar) Globally unique identifier for the project.}

\item{limit}{(optional) (integer scalar) Results per page. The number of objects to return per page. The value must be between 1 and 100.}

\item{offset}{(optional) (character scalar) Offset token. An offset to the next page returned by the API. A pagination request will return an offset token, which can be used as an input parameter to the next request. If an offset is not passed in, the API will return the first page of results. 'Note: You can only pass in an offset that was returned to you via a previously paginated request.'}

\item{opt_fields}{(optional) (list) Defines fields to return. Some requests return \emph{compact} representations of objects in order to conserve resources and complete the request more efficiently. Other times requests return more information than you may need. This option allows you to list the exact set of fields that the API should be sure to return for the objects. The field names should be provided as paths, described below. The id of included objects will always be returned, regardless of the field options.}
}
\value{
Custom Fields Settings objects represent the many-to-many join of the Custom Field and Project as well as stores information that is relevant to that particular pairing.\tabular{lll}{
   \strong{Property} \tab \strong{Class} \tab \strong{Description} \cr
   gid \tab character scalar \tab Globally unique identifier of the resource, as a string. \cr
   resource_type \tab character scalar \tab The base type of this resource. \cr
   custom_field \tab list \tab The custom field that is applied to the \code{parent}. \cr
   is_important \tab logical scalar \tab \code{is_important} is used in the Asana web application to determine if this custom field is displayed in the list/grid view of a project or portfolio. \cr
   parent \tab list \tab The parent to which the custom field is applied. This can be a project or portfolio and indicates that the tasks or projects that the parent contains may be given custom field values for this custom field. \cr
   project \tab list \tab \emph{Deprecated: new integrations should prefer the \code{parent} field.} The id of the project that this custom field settings refers to. \cr
}
}
\description{
Returns a list of all of the custom fields settings on a project, in compact form. Note that, as in all queries to collections which return compact representation, \code{opt_fields} can be used to include more data than is returned in the compact representation. See the \href{https://developers.asana.com/docs/#input-output-options}{getting started guide on input/output options} for more information.
}
\keyword{internal}
