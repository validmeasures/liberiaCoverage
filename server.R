################################################################################
#
#
#
# This is a Shiny web application to support the implementation of health and
# nutrition coverage surveys in Liberia.
# 
# This code is for the server logic function of the Shiny web aplication.
#
#
################################################################################


################################################################################
#
# Server logic for web application
#
################################################################################
#
# Define server logic for application
#
server <- function(input, output) {
  output$descriptionImam <- renderUI({
    HTML("
      <p>IMAM coverage usually pertains to coverage of SAM treatment. IMAM coverage has two indicators:</p>
      <ul>
        <li>Case-finding effectiveness</li>
        $$\\begin{aligned} 
        \\text{Case-finding effectiveness} & ~ = ~ \\frac{C_{in}}{C_{in} ~ + ~ C_{out}} \\\\
        \\\\
        where: & \\\\
        \\\\
        C_{in} & ~ = ~ \\text{current SAM cases in the programme} \\\\
        C_{out} & ~ = ~ \\text{current SAM cases out of the programme}
        \\end{aligned}$$
        <br/>
        <li>Treatment coverage</li>
        $$\\begin{aligned}
        \\text{Treatment coverage} & ~ = ~ \\frac{C_{in} ~ + ~ R_{in}}{C_{in} ~ + ~ R_{in} ~ + ~ C_{out} ~ + ~ R_{out}} \\\\
        \\\\
        where: & \\\\
        \\\\
        R_{in} & ~ = ~ \\text{Recovering SAM cases in the programme} \\\\
        R_{out} & ~ = ~ \\text{Recovering SAM cases not in the programme}
        \\end{aligned}$$         
    ")
  })
  output$descriptionVita <- renderUI({
    HTML("
      <p>The standard estimator for vitamin A supplementation is the proportion of children aged 6-59 months who received two age-appropriate doses of vitamin A in the past 12 months.</p>

      <p>In standard surveys such as the DHS and MICS, this indicator is adjusted to a recall of 6 months for a single age-appropriate dose of vitamin A.</p>

      <p>In order to determine whether supplementation with vitamin A is age appropriate, vitamin A supplementation should first be assessed on the child's health card. Provision of vitamin A card is usually recorded on the child's health card with the corresponding does given. If health card not available or if health card is lost or if the child doesn't have a health card at all, then the mother/caregiver will have to be asked whether their child has received vitamin A in the past 6 months and respond by recall. If the mother/caregiver says yes, then the next question to ask will be which type of gel capsule was provided. The blue vitamin A gel capsule containing 100,000 IU of vitamin A is given to children 6-11 months. The red vitamin A gel capsule containing 200,000 IU of vitamin A is given to children 12 - 59 months. A sample of the blue and the red gel capsule (or a photo of the capsules) can be used to aid the mother/caregiver in answering this question.</p> 

      <p>Given this, two indicators can be reported on vitamin A supplementation.</p>

      <ol>
        <li>Any vitamin A supplementation in the past 6 months.</li>
        <br/>
        <li>Age-appropriate vitamin A supplementation in the past 6 months.</li>
    ")
  })
  output$descriptionFefol <- renderUI({
    HTML("
      <p>Population-based surveys typically report the percentage of women with a live birth in the two to five years before the survey who received and took IFA supplementation during their most recent pregnancy. Because antenatal care (ANC) is typically the main platform for IFA supplement distribution for pregnant women, survey questions on antenatal care attendance and timing of the first antenatal care visit can provide information on the use of this platform to deliver IFA supplementation. Sununtnasuk et al propose a falter point framework that utilises four indicators that proxy the four critical points at which the ANC approach to IFA distribution might falter in IFA supplementation coverage to pregnant women. These indicators are:</p>
      <ol>
        <li>At least one ANC visit during most recent pregnancy</li>
        <br/>
        <li>Receipt or purchase of IFA tablet/s</li>
        <br/> 
        <li>IFA consumption</li>
        <br/> 
        <li>Adherence to 180 days of supplementation</li>
      ")
  })
  output$descriptionMnp <- renderUI({
    HTML("
      <p>The indicator for coverage of micronutrient powder supplementation is the proportion of children aged 6-23 months who consume micronutrient powder supplements. Depending on the programme protocol on mechanism of distribution and effective intake of MNP, a full indicator set on MNP supplementation can be devised that will be similar to the IFA supplementation falter point or bottleneck framework. For example, if MNPs were being provided through the health centres or health posts, then the following indicators can be assessed hierarchically:</p>
      <ol>
        <li>Health centre / health post attendance in the past month</li>
        <br/> 
        <li>Awareness of MNP</li>
        <br/> 
        <li>Consumption of MNP</li>
      ")
  })
  output$descriptionIycf <- renderUI({
    HTML("
      <p>There are no standard indicators for IYCF counselling. Any indicator developed for this programme will depend on the mechanics of how the IYCF counselling is delivered and who the target beneficiaries are. In terms of mechanism, what is known so far is that these sessions are delivered via the health clinic/health post and that the target beneficiaries are pregnant women. Given this, similar approach to the IFA supplementation coverage of falter points/bottle necks can be used with the following indicators:</p>
      <ol>
        <li>At least one ANC visit during most recent pregnancy</li>
        <br/> 
        <li>Awareness of IYCF counselling (have they been advised IYCF counselling when they attended ANC)</li>
        <br/> 
        <li>Attendance to IYCF counselling</li>
      ")
  })
}
