# Source: https://github.com/soleo/front-end-building-checklist

library = Library.find_by(public: true)


unless library.checklists.find_by(title: 'Front End Feature Building Checklist')
  library.checklists.create(
    type: 'Checklists::Single',
    title: 'Front End Feature Building Checklist',
    content: <<~CONTENT,
      # Front End Feature Building Checklist

      ## Before Building

      - [ ] Have clear idea of the business requirements
      - [ ] Get UX/UI designer's mock-ups and understand what the designer's visions are, and how they fit in our current design system
      - [ ] Understand the current design system, and what are the possible impacts for current layouts

      ## During Development Process

      - [ ] Have consistent naming conventions, preferably enforced by a linter (e.g. eslint)
      - [ ] Used preferred way for layouts (grid > flexbox > absolute/relative position)
      - [ ] Consolidate similar elements or make them re-usable
      - [ ] The boy scout rule: everywhere you touched is cleaner than before
      - [ ] [SOLID](https://en.wikipedia.org/wiki/SOLID) and [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)?

      ## Before Testing/QA

      - [ ] Created pull request for code review
      - [ ] Check in different browsers (Check on Chrome, FireFox, Safari, Edge)
      - [ ] Check in native apps (iOS/Android)
      - [ ] Works well in different break points (Mobile, Tablet, Desktop) and different length of text sizes
      - [ ] Check voice over in Safari for your feature
      - [ ] Profile in ChromeDevTool to see any performance issues
      - [ ] Check color contrast
      - [ ] Add unit tests to your feature
      - [ ] Add documentation for future/peer developers

      ## Before Deployment

      - [ ] Feature branch is synchronized with master
      - [ ] Add configuration changes

      ## After Deployment

      - [ ] 🎉 Celebrate and watch what kind of impact/usage the feature going to bring.
    CONTENT
  )
end

unless library.checklists.find_by(title: 'Sustainable Development Goals')
  library.checklists.create(
    type: 'Checklists::Single',
    title: 'Sustainable Development Goals',
    content: <<~CONTENT,
      # Sustainable Development Goals

      ## Goal 1. End poverty in all its forms everywhere

      - [ ] 1.1 Eradicate extreme poverty
      - [ ] 1.2 Reduce poverty by at least 50%
      - [ ] 1.3 Implement nationally appropriate social protection systems
      - [ ] 1.4 Equal rights to ownership, basic services, technology, and economic resources
      - [ ] 1.5 Build resilience to environmental, economic, and social disasters
      - [ ] 1.a Mobilization of resources to end poverty
      - [ ] 1.b Establishment of poverty eradication policy frameworks at all levels

      ## Goal 2. End hunger, achieve food security and improved nutrition and promote sustainable agriculture

      - [ ] 2.1 Universal access to safe and nutritious food
      - [ ] 2.2 End all forms of malnutrition
      - [ ] 2.3 Double the productivity and incomes of small-scale food producers
      - [ ] 2.4 Sustainable food production and resilient agricultural practices
      - [ ] 2.5 Maintain the genetic diversity in food production
      - [ ] 2.a Invest in rural infrastructure, agricultural research, technology and gene banks
      - [ ] 2.b Prevent agricultural trade restrictions, market distortions and export subsidies
      - [ ] 2.c Ensure stable food commodity markets and timely access to information

      ## Goal 3. Ensure healthy lives and promote well-being for all at all ages

      - [ ] 3.1 Reduce maternal mortality
      - [ ] 3.2 End all preventable deaths under five years of age
      - [ ] 3.3 Fight communicable diseases
      - [ ] 3.4 Reduce mortality from non-communicable diseases and promote mental health
      - [ ] 3.5 Prevent and treat substance abuse
      - [ ] 3.6 Reduce road injuries and deaths
      - [ ] 3.7 Universal access to sexual and reproductive care, family planning and education
      - [ ] 3.8 Achieve universal health coverage
      - [ ] 3.9 Reduce illnesses and deaths from hazardous chemicals and pollution
      - [ ] 3.a Implement the WHO framework convention on tobacco control
      - [ ] 3.b Support research, development and universal access to affordable vaccines and medicines
      - [ ] 3.c Increase health financing and support health workforce in developing countries
      - [ ] 3.d Improve early warning systems for global health risks

      ## Goal 4. Ensure inclusive and equitable quality education and promote lifelong learning opportunities for all

      - [ ] 4.1 Free primary and secondary education
      - [ ] 4.2 Equal access to quality pre-primary education
      - [ ] 4.3 Equal access to affordable technical, vocational, and higher education
      - [ ] 4.4 Increase the number of people with relevant skills for financial success
      - [ ] 4.5 Eliminate all discrimination in education
      - [ ] 4.6 Universal literacy and numeracy
      - [ ] 4.7 Education for sustainable development and global citizenship
      - [ ] 4.a Build and upgrade inclusive and safe schools
      - [ ] 4.b Expand higher education scholarships for developing countries
      - [ ] 4.c Increase the supply of qualified teachers in developing countries

      ## Goal 5. Achieve gender equality and empower all women and girls

      - [ ] 5.1 End discrimination against women and girls
      - [ ] 5.2 End all violence against and exploitation of women and girls
      - [ ] 5.3 Eliminate forced marriages and genital mutilation
      - [ ] 5.4 Value unpaid care and promote shared domestic responsibilities
      - [ ] 5.5 Ensure full participation in leadership and decision-making
      - [ ] 5.6 Universal access to reproductive rights and health
      - [ ] 5.a Equal rights to economic resources, property ownership and financial services
      - [ ] 5.b Promote empowerment of women through technology
      - [ ] 5.c Adopt and strengthen policies and enforceable legislation for gender equality

      ## Goal 6. Ensure availability and sustainable management of water and sanitation for all

      - [ ] 6.1 Safe and affordable drinking water
      - [ ] 6.2 End open defecation and provide access to sanitation and hygiene
      - [ ] 6.3 Improve water quality, wastewater treatment, and safe reuse
      - [ ] 6.4 Increase water-use efficiency and ensure freshwater supplies
      - [ ] 6.5 Implement integrated water resources management
      - [ ] 6.6 Protect and restore water-related ecosystems
      - [ ] 6.a Expand water and sanitation support to developing countries
      - [ ] 6.b Support local engagement in water and sanitation management

      ## Goal 7. Ensure access to affordable, reliable, sustainable and modern energy for all

      - [ ] 7.1 Universal access to modern energy
      - [ ] 7.2 Increase global percentage of renewable energy
      - [ ] 7.3 Double the improvement in energy efficiency
      - [ ] 7.a Promote access to research, technology and investments in clean energy
      - [ ] 7.b Expand and upgrade energy services for developing countries

      ## Goal 8. Promote sustained, inclusive and sustainable economic growth, full and productive employment and decent work for all

      - [ ] 8.1 Sustainable economic growth
      - [ ] 8.2 Diversify, innovate and upgrade for economic productivity
      - [ ] 8.3 Promote policies to support job creation and growing enterprises
      - [ ] 8.4 Improve resource efficiency in consumption and production
      - [ ] 8.5 Full employment and decent work with equal pay
      - [ ] 8.6 Promote youth employment, education and training
      - [ ] 8.7 End modern slavery, trafficking, and child labour
      - [ ] 8.8 Protect labour rights and promote safe working environments
      - [ ] 8.9 Promote beneficial and sustainable tourism
      - [ ] 8.10 Universal access to banking, insurance and financial services
      - [ ] 8.a Increase aid for trade support
      - [ ] 8.b Develop a global youth employment strategy

      ## Goal 9. Build resilient infrastructure, promote inclusive and sustainable industrialization and foster innovation

      - [ ] 9.1 Develop sustainable, resilient and inclusive infrastructures
      - [ ] 9.2 Promote inclusive and sustainable industrialization
      - [ ] 9.3 Increase access to financial services and markets
      - [ ] 9.4 Upgrade all industries and infrastructures for sustainability
      - [ ] 9.5 Enhance research and upgrade industrial technologies
      - [ ] 9.a Facilitate sustainable infrastructure development for developing countries
      - [ ] 9.b Support domestic technology development and industrial diversification
      - [ ] 9.c Universal access to information and communications technology

      ## Goal 10. Reduce inequality within and among countries

      - [ ] 10.1 Reduce income inequalities
      - [ ] 10.2 Promote universal social, economic and political inclusion
      - [ ] 10.3 Ensure equal opportunities and end discrimination
      - [ ] 10.4 Adopt fiscal and social policies that promotes equality
      - [ ] 10.5 Improved regulation of global financial markets and institutions
      - [ ] 10.6 Enhanced representation for developing countries in financial institutions
      - [ ] 10.7 Responsible and well-managed migration policies
      - [ ] 10.a Special and differential treatment for developing countries
      - [ ] 10.b Encourage development assistance and investment in least developed countries
      - [ ] 10.c Reduce transaction costs for migrant remittances

      ## Goal 11. Make cities and human settlements inclusive, safe, resilient and sustainable

      - [ ] 11.1 Safe and affordable housing
      - [ ] 11.2 Affordable and sustainable transport systems
      - [ ] 11.3 Inclusive and sustainable urbanization
      - [ ] 11.4 Protect the world's cultural and natural heritage
      - [ ] 11.5 Reduce the adverse effects of natural disasters
      - [ ] 11.6 Reduce the environmental impacts of cities
      - [ ] 11.7 Provide access to safe and inclusive green and public spaces
      - [ ] 11.a Strong national and regional development planning
      - [ ] 11.b Implement policies for inclusion, resource efficiency and disaster risk reduction
      - [ ] 11.c Support least developed countries in sustainable and resilient building

      ## Goal 12. Ensure sustainable consumption and production patterns

      - [ ] 12.1 Implement the 10-year sustainable consumption and production framework
      - [ ] 12.2 Sustainable management and use of natural resources
      - [ ] 12.3 Halve global per capita food waste
      - [ ] 12.4 Responsible management of chemicals and waste
      - [ ] 12.5 Substantially reduce waste generation
      - [ ] 12.6 Encourage companies to adopt sustainable practices and sustainability reporting
      - [ ] 12.7 Promote sustainable public procurement practices
      - [ ] 12.8 Promote universal understanding of sustainable lifestyles
      - [ ] 12.a Support developing countries' scientific and technological capacity for sustainable consumption and production
      - [ ] 12.b Develop and implement tools to monitor sustainable tourism
      - [ ] 12.c Remove market distortions that encourage wasteful consumption

      ## Goal 13. Take urgent action to combat climate change and its impacts

      - [ ] 13.1 Strengthen resilience and adaptive capacity to climate-related disasters
      - [ ] 13.2 Integrate climate change measures into policy and planning
      - [ ] 13.3 Build knowledge and capacity to meet climate change
      - [ ] 13.a Implement the United Nations Framework Convention on Climate Change
      - [ ] 13.b Promote mechanisms to raise capacity for planning and management

      ## Goal 14. Conserve and sustainably use the oceans, seas and marine resources for sustainable development

      - [ ] 14.1 Reduce marine pollution
      - [ ] 14.2 Protect and restore ecosystems
      - [ ] 14.3 Reduce ocean acidification
      - [ ] 14.4 Sustainable fishing
      - [ ] 14.5 Conserve coastal and marine areas
      - [ ] 14.6 End subsidies contributing to overfishing
      - [ ] 14.7 Increase the economic benefits from sustainable use of marine resources
      - [ ] 14.a Increase scientific knowledge, research and technology for ocean health
      - [ ] 14.b Support small scale fishers
      - [ ] 14.c Implement and enforce international sea law

      ## Goal 15. Protect, restore and promote sustainable use of terrestrial ecosystems, sustainably manage forests, combat desertification, and halt and reverse land degradation and halt biodiversity loss

      - [ ] 15.1 Conserve and restore terrestrial and freshwater ecosystems
      - [ ] 15.2 End deforestation and restore degraded forests
      - [ ] 15.3 End desertification and restore degraded land
      - [ ] 15.4 Ensure conservation of mountain ecosystems
      - [ ] 15.5 Protect biodiversity and natural habitats
      - [ ] 15.6 Protect access to genetic resources and fair sharing of the benefits
      - [ ] 15.7 Eliminate poaching and trafficking of protected species
      - [ ] 15.8 Prevent invasive alien species on land and in water ecosystems
      - [ ] 15.9 Integrate ecosystem and biodiversity in governmental planning
      - [ ] 15.a Increase financial resources to conserve and sustainably use ecosystem and biodiversity
      - [ ] 15.b Finance and incentivize sustainable forest management
      - [ ] 15.c Combat global poaching and trafficking

      ## Goal 16. Promote peaceful and inclusive societies for sustainable development, provide access to justice for all and build effective, accountable and inclusive institutions at all levels

      - [ ] 16.1 Reduce violence everywhere
      - [ ] 16.2 Protect children from abuse, exploitation, trafficking and violence
      - [ ] 16.3 Promote the rule of law and ensure equal access to justice
      - [ ] 16.4 Combat organized crime and illicit financial and arms flows
      - [ ] 16.5 Substantially reduce corruption and bribery
      - [ ] 16.6 Develop effective, accountable and transparent institutions
      - [ ] 16.7 Ensure responsive, inclusive and representative decision-making
      - [ ] 16.8 Strengthen the participation in global governance
      - [ ] 16.9 Provide universal legal identity
      - [ ] 16.10 Ensure public access to information and protect fundamental freedoms
      - [ ] 16.a Strengthen national institutions to prevent violence and combat crime and terrorism
      - [ ] 16.b Promote and enforce non-discriminatory laws and policies

      ## Goal 17. Strengthen the means of implementation and revitalize the global partnership for sustainable development

      - [ ] 17.1 Mobilize resources to improve domestic revenue collection
      - [ ] 17.2 Implement all development assistance commitments
      - [ ] 17.3 Mobilize financial resources for developing countries
      - [ ] 17.4 Assist developing countries in attaining debt sustainability
      - [ ] 17.5 Invest in least-developed countries
      - [ ] 17.6 Knowledge sharing and cooperation for access to science, technology and innovation
      - [ ] 17.7 Promote sustainable technologies to developing countries
      - [ ] 17.8 Strengthen the science, technology and innovation capacity for least-developed countries
      - [ ] 17.9 Enhanced SDG capacity in developing countries
      - [ ] 17.10 Promote a universal trading system under the WTO
      - [ ] 17.11 Increase the exports of developing countries
      - [ ] 17.12 Remove trade barriers for least-developed countries
      - [ ] 17.13 Enhance global macroeconomic stability
      - [ ] 17.14 Enhance policy coherence for sustainable development
      - [ ] 17.15 Respect national leadership to implement policies for the sustainable development goals
      - [ ] 17.16 Enhance the global partnership for sustainable development
      - [ ] 17.17 Encourage effective partnerships
      - [ ] 17.18 Enhance availability of reliable data
      - [ ] 17.19 Further develop measurements of progress
      CONTENT
  )
end
