# snapshots for body_()

    <div class="content-wrapper">
      <section class="content">
        <div class="tab-content">
          <div role="tabpanel" class="tab-pane container-fluid" id="shiny-tab-R-downloads">
            <div class="row">
              <div class="col-sm-12">
                <div class="card card-primary card-outline">
                  <div class="card-header">
                    <h3 class="card-title">Visualize R Package Download History</h3>
                    <div class="card-tools float-right">
                      <span class="badge bg-primary" title="The inspiration of this visualization comes from Hadley Wickham." data-toggle="tooltip">Credit</span>
                      <button class="btn btn-tool btn-sm" type="button" data-card-widget="collapse">
                        <i class="fa fa-minus" role="presentation" aria-label="minus icon"></i>
                      </button>
                      <button type="button" class="btn btn-tool btn-sm" data-card-widget="maximize">
                        <i class="fa fa-expand" role="presentation" aria-label="expand icon"></i>
                      </button>
                    </div>
                  </div>
                  <div class="card-body">
                    <div class="form-group shiny-input-container">
                      <label class="control-label" id="R_packages-label" for="R_packages">Packages</label>
                      <input id="R_packages" type="text" class="form-control" value="dplyr"/>
                    </div>
                    <div id="R_date_range_input" class="shiny-date-range-input form-group shiny-input-container">
                      <label class="control-label" id="R_date_range_input-label" for="R_date_range_input">Select a data range:</label>
                      <div class="input-daterange input-group input-group-sm">
                        <input class="form-control" type="text" aria-labelledby="R_date_range_input-label" title="Date format: yyyy-mm-dd" data-date-language="en" data-date-week-start="0" data-date-format="yyyy-mm-dd" data-date-start-view="month" data-initial-date="2021-12-27" data-date-autoclose="true"/>
                        <span class="input-group-addon input-group-prepend input-group-append">
                          <span class="input-group-text"> to </span>
                        </span>
                        <input class="form-control" type="text" aria-labelledby="R_date_range_input-label" title="Date format: yyyy-mm-dd" data-date-language="en" data-date-week-start="0" data-date-format="yyyy-mm-dd" data-date-start-view="month" data-initial-date="2022-02-25" data-date-autoclose="true"/>
                      </div>
                    </div>
                    <div id="R_plot" style="width:100%; height:400px; " class="plotly html-widget html-widget-output shiny-report-size shiny-report-theme"></div>
                  </div>
                </div>
                <script type="application/json">{"title":"Visualize R Package Download History","status":"primary","solidHeader":false,"width":12,"collapsible":true,"closable":false,"maximizable":true,"gradient":false}</script>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>

