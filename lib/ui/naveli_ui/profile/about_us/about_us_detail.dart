import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:naveli_2023/ui/app/app_model.dart';
import 'package:provider/provider.dart';
import '../../../../generated/i18n.dart';
import '../../../../widgets/common_appbar.dart';

class AboutUsDetail extends StatelessWidget {
  const AboutUsDetail({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    var lang = Provider.of<AppModel>(context).locale;

    String content;
    if (title == S.of(context)!.ourMissionAndVision) {
      content = lang == 'hi' ? missionVisionHtmlHindi : missionVisionHtml;
    } else if (title == S.of(context)!.ourTeam) {
      content = lang == 'hi' ? ourTeamHtmlHindi : ourTeamHtml;
    } else if (title == S.of(context)!.privacyPolicy) {
      content = privacyPolicyHtml;
    } else if (title == S.of(context)!.termsOfUse) {
      content = termsAndConditionsHtml;
    } else {
      content = "Default about us content.";
    }
    return SafeArea(
        child: Scaffold(
      appBar: CommonAppBar(
        title: title,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: SingleChildScrollView(
          child: Html(
            data: content,
            style: {
              "body": Style(
                fontSize: FontSize(16),
                color: Colors.black,
              ),
            },
          ),
        ),
      ),
    ));
  }
}

const String missionVisionHtml = '''
<b>Vision</b><br>
<div style="text-align: start;">
At NeoW, we envision a world where every woman feels empowered, informed, and in control of her well-being. Rooted in the belief that health is the foundation of confidence and self-expression, our vision is to be the most trusted platform for supporting women’s holistic growth—physically, mentally, and emotionally.<br>
We aspire to break barriers, bridge gaps, and build a future where access to knowledge, wellness resources, and supportive communities is universal—regardless of geography, income, or background. By combining innovation with empathy, and sustainability with simplicity, we’re creating a movement toward healthier women and a healthier planet.<br>
NeoW stands for New Woman—and through this vision, we’re helping every woman step into her power.<br><br>

<b>Mission</b><br>
Our mission is to simplify and elevate women’s wellness through smart, inclusive, and holistic digital tools. We’re here to make well-being a daily habit—not a luxury—by offering women a seamless platform that understands their needs and adapts to their lives.<br>
We are committed to:<br>
<b>Empowering Women:</b> By equipping them with the knowledge, tools, and confidence to understand and manage their health and wellness on their own terms.<br>
<b>Enabling Access:</b> By creating an app that is intuitive, inclusive, and accessible to women from all walks of life.<br>
<b>Driving Innovation:</b> By leveraging technology, data, and expert insights to deliver personalized wellness guidance that evolves with each user.<br>
<b>Championing Sustainability:</b> By adopting mindful practices in our content, partnerships, and design philosophy—ensuring we contribute to a better world.<br>
<b>Normalizing Conversations:</b> By encouraging open dialogue around women’s health and dismantling stigmas through education, storytelling, and community engagement.<br>
At NeoW, wellness isn’t a feature. It’s a mindset—and we’re on a mission to help women embrace it.
</div>
''';

const String ourTeamHtml = '''
<b>Our Team</b><br>
Behind NeoW is a passionate team of innovators, medical professionals, and changemakers driven by one purpose: to transform how women engage with their health.<br><br>

<b>Medical Experts:</b><br>
Guided by clinicians and wellness professionals from AIIMS and other top institutions, our app is rooted in real science and practical experience. Their insights help shape health features that are accurate, relevant, and empathetic.<br><br>

<b>Tech & Innovation Leaders:</b><br>
Our engineers and designers from premier institutes like the IITs bring NeoW’s vision to life through clean design, user-first interfaces, and secure technology that adapts to women’s needs.<br><br>

<b>Purpose-Led Leadership:</b><br>
Our leadership combines entrepreneurial drive with deep commitment to social good. With a strong focus on impact, inclusion, and long-term vision, they ensure NeoW stays aligned with its mission to empower women.<br><br>

<b>Culture of Collaboration:</b><br>
NeoW thrives on teamwork, diversity, and shared purpose. We believe the best solutions come from collective insight—and we cultivate a space where bold ideas, diverse voices, and compassionate problem-solving lead the way.<br><br>

<b>Driven by Impact:</b><br>
Together, we are more than a team—we are a community shaping the future of women’s wellness. With every feature we build and every challenge we tackle, we stay focused on one goal: making life healthier, simpler, and more empowering for women everywhere.
''';
const String termsAndConditionsHtml = '''
<b>Terms and Conditions</b><br><br>

<b>1. Introduction</b><br>
1.1. These Terms of Service (hereinafter referred to as "Terms") govern the mobile application developed by Naveli India Biotech including all services provided through our App and our website.<br>
1.2. In addition to these Terms, the <b>Privacy Policy</b> available on our website details your and our respective rights and obligations in connection with applicable data protection laws, in particular regarding processing of your sensitive health data.<br>
1.3. Notwithstanding the requirement for a valid consent to processing your personal data under our Privacy Policy, you must be at least 18 years old (minimum age) to use our Paid Services. If a minor (a person reaches majority at 18 under India law) uses the Paid Services offered by our Mobile App, we provide the services on the basis of the deemed consent of their parent or guardian, both to these Terms and to the use of our App. Such consent is obtained when an account is created prior to first use of the app. The parent or guardian takes full responsibility for the minor's use of our Mobile App’s paid services.<br><br>

<b>2. Scope of application and amendments to these Terms</b><br>
2.1. By using the App’s Services, you agree to these Terms.<br>
2.2. We will always ask for your consent to material changes to these Terms if they affect any Paid Services. Material changes are changes to the type and scope of the contractually agreed Paid Services, or the duration and termination of the contract. However, this does not prevent us from improving our services or including additional features or services within the scope of Paid Services.<br>
2.3. We may make non-material amendments to these Terms at any time. We may implement non-material changes without notice or stating further reasons. There are no oral or written side agreements under these Terms.<br><br>

<b>3. Disclaimer</b><br>
3.1. The Services offered by our Mobile App are not intended to provide professional advice. For professional advice, including legal advice that addresses your specific, individual needs, you are advised to consult a qualified professional.<br>
When using our App Services, you agree to use the respective service only for the intended purposes as described in these Terms.<br>
3.2. We are no substitute for a consultation with your service provider, and the use of our App Services is for informational and awareness purpose. Your specific conditions can only be diagnosed and treated properly by a qualified professional.<br><br>

<b>4. General scope of services of our App, and other Premium Features of our Mobile Application</b><br>
4.1. Our Mobile Application is designed to provide general information about related topics. The app collects the data you enter. These data allow statistical and algorithmic data processing that can show you patterns which might not always be accurate.<br>
4.2. Our App is a self-management app. This means that our App’s services are based on the data that you provide, so the information and analysis available in the app depends on the amount and accuracy of the inputs you choose to record.<br>
4.3. Our App offers some functions and content free of charge while access to more extensive functions and content is paid. The basic app can be acquired free of charge from the relevant app store (if you have an iPhone, the Apple App Store, or if you have an Android phone, the Google Play Store). In addition, you can purchase the Paid Services and other Premium Features, from within the basic version of our App.<br>
4.4. In order to help us continue to provide the Services, we reserve the right to display advertisements on our website or in our app. We may also offer the opportunity to donate via the website or app, so that you can support our services and mission.<br><br>

<b>5. Creating an account</b><br>
5.1. To use our App, you need to create an account. This requires an acceptance of these Terms and consent to data processing under the terms of our Privacy Policy, including all documents, declarations and consents included therein by reference. Furthermore, you will need to provide a username, email address, and a mobile number. In addition, you can provide other information as part of your onboarding, in order to personalize your experience with our App from the very start itself.<br>
5.2. When you create an account, you assure that all of the information you provide is correct and complete and you give your consent to analyse the data for the results you may require to see accordingly. We recommend that you secure your data as permitted by your device.<br><br>

<b>6. Plus and Premium Features (together, the "Paid Services")</b><br>
6.1. Within the free App, we offer certain features and enhanced functionality as Paid Services. These are referred to as Plus and other Premium Features. These services are generally tied to a subscription, i.e. the regular purchase of the services over a fixed period of time for a specific fee.<br>
6.2. You can find an overview of the benefits included in a Plus subscription on our website. These may change from time to time, as we introduce new features, develop our existing offering and sometimes retire features that aren't working out as planned. The features and content contained in different Paid Services may differ by country and language. The applicable price offer is shown in the relevant app store (Apple App Store or Google Play store) and on the buy screen in-app prior to purchase.<br>
6.3. Like the basic app itself, the paid subscription version of our App is only available via the third-party platform operators Apple App Store and Google Play Store. Therefore, when you make a purchase within our paid App, you may additionally enter into a separate contract with the respective third-party service provider providing your app store, whose terms and conditions may apply. Depending on the respective third-party service provider’s terms and conditions, you may need to exercise your rights of cancellation and revocation with these service providers.<br>
6.4. Our App does not store your payment information at any time.<br>
6.5. The Paid Services are generally available on a subscription basis. Therefore, you will be charged once in the duration period of your subscription (for instance per month or per year). Our subscription will automatically be renewed for an indefinite time at the end of your initial subscription period, unless we or you have cancelled your subscription or disabled auto-renewal or you have concluded a new contract with a new initial subscription period with us. In case of an indefinite subscription period after the end of your applicable initial subscription period, you may cancel your subscription with a notice period of at least 24 hours to the end of each subscription month.<br>
6.6. If payment cannot be collected, we will be entitled to block access to the relevant Paid Services.<br>
6.7. You agree to provide current, complete and accurate purchase and account information for all purchases made for Paid Services. You agree to promptly update your account and other information, including your email address and credit card numbers and expiration dates, so that we can complete your transactions and contact you as needed. You will be responsible for any applicable sales, use, duty, customs or other governmental taxes, levies or fees due with respect to your purchase of the our App’s Services.<br>
By agreeing to these Terms, you acknowledge and agree that you have the financial responsibility for all the Paid Services purchased with your account.<br><br>

<b>7. Your rights and duties as a user</b><br>
7.1. You shall not cause to transfer your user account to third parties as long as you use our Mobile App. You shall only use our Mobile App for your own private purposes or for such other purposes as we explicitly agree to in writing (for example, if you are an academic researcher and we enter into a research collaboration agreement).<br>
7.2. Furthermore, you are not permitted to:<br>
<ul>
<li>make the access data sent or used for authentication and identification available to third parties or to pass them on to third parties;</li>
<li>bypass the access control systems of paid services or to take other measures in order to use services without authorization;</li>
<li>remove or obscure copyright notices and/or notices regarding trademarks or other intellectual property rights of our App, companies affiliated with us or third parties;</li>
<li>transfer or assign rights or obligations under these Terms to third parties.</li>
</ul>
7.3. When using the Mobile App and services provided through the app, you must observe your contractual obligations with third parties, in particular your internet access provider and the relevant app store operator.<br>
7.4. For the best experience of the our App’s Services, you must regularly update your operating systems and the version of our App on your device. It is also possible that certain activations may be required to make full use of the service. From time to time, the our App may automatically download and install updates and upgrades without specifically informing you. These updates are intended to technically improve and/or enhance the software and service. You agree that we may implement such updates as part of your use of our App’s Services.<br>
7.5. You are only entitled to a right of legal or equitable set-off insofar as you may have legally established a counterclaim against us, or we do not dispute such counterclaim. A right of retention arises only if and insofar as the counterclaim is based on the same contractual relationship.<br><br>

<b>8. Copyright</b><br>
8.1. All of the content that we make available within our App or on our website is subject to Indian copyright law unless otherwise indicated. The reproduction, processing, distribution and any form of commercial exploitation of the content, services and software requires our written consent.<br>
8.2. The use of the services (and/or the provision of input information) does not give you any legal rights, titles or legal interests in our services or software. The service and software are protected by copyright law, trademark law, intellectual property rights and other applicable laws.<br>
8.3. Our App is a copyright protected software program. You as a user are granted a simple, non-exclusive, non-transferable and revocable right for personal use. You are not entitled to decompile, change or edit the App beyond the extent permissible by law. You are not permitted to lease, rent or otherwise transfer the app and/or its contents.<br>
8.4. The commercial use or retransmission of the Services offered by our App is prohibited. In particular, you may not copy or publish any part of our App or the website version of our App.<br>
8.5. We use anonymous information from your usage of our App’s Services so that we can continue to improve them and for scientific research. We process personal information for these purposes also, as set out in detail in our Privacy Policy which you also consent to when you create an user account and use our App. In addition, you agree that by creating an account and using our App, you grant us permission to use your anonymous information to improve our App’s Services for all users and advance scientific research.<br><br>

<b>9. Liability</b><br>
9.1. The content that we provide through our App’s services has been compiled with the greatest care. However, we cannot accept any liability for the accuracy, completeness and updation of the content. We are also in no way responsible or liable for the content you track or otherwise provide in the App ("user content"). You are solely responsible for the security of your personal user content. Except to the extent required by law, we accept no liability for the deletion, damage or failure to store user content maintained or transmitted through the use of our App’s Services.<br>
9.2. When you use our App’s Services, you do so expressly at your own risk. The descriptions of our different services - whether the basic free versions of our App, including its paid versions, or other Premium Services - are not subject to any guarantees. We give no guarantee that any of our services can be used to achieve a specific aim, such as correct prediction of your requirements, or that our App’s outputs are complete and accurate.<br>
9.3. We expressly point out that any health-related recommendations provided in the context of our App’s Services are general and suggestive in nature, and aimed at users who are generally healthy and physically and mentally fit. We give references to published research and other sources wherever possible, so that you can find out more and evaluate the information for yourself. If you choose to follow any such general recommendations, you do so at your own risk. If you have any doubt as to whether this is appropriate for you, please speak to your qualified healthcare provider. This applies especially if you are underage, pregnant, breastfeeding or elderly.<br>
9.4. Any liability in respect of contractual or other claims made by you as a user depends on the merits of the case and extends only to actual damage suffered<br>
(a) which we, our legal representatives or vicarious agents have caused intentionally or by gross negligence,<br>
(b) from injury to life, body or health resulting from a breach of duty by us or one of our legal representatives or vicarious agents,<br>
(c) in cases of liability under the Indian Contract Act, due to us having given a guarantee or due to fraudulent misrepresentation, and<br>
(d) which has arisen due to the breach of a fundamental obligation, the fulfilment of which is of fundamental importance to the proper execution of the contract, and which you are entitled to rely on and in fact regularly rely on (under Indian law, a statutory obligation).<br>
9.5. We are liable without limitation in the above-mentioned cases (a), (b) and (c) of the preceding paragraph. In all other cases, liability shall be limited to the reasonably foreseeable damage under these terms.<br>
9.6. In cases other than those specified in 9.4. and 9.5. and notwithstanding the following paragraph, liability on our part is excluded irrespective of the legal grounds.<br>
9.7. The above limitations of liability apply equally to all of our legal entities, employees and vicarious agents. They do not alter the statutory burden of proof.<br><br>

<b>10. Contract duration, termination, refunds</b><br>
10.1. In relation to the free service offered by our App, you may terminate the contractual relationship with us at any time by deleting your account in accordance with the instructions in the app. We too may terminate the contract at our sole discretion and without further notice, subject to the following provisions.<br>
10.2. The Paid Services run for the agreed (initial) term. At the end of the term, the contract is automatically extended for an indefinite time period, unless you or we terminate it before the end of the agreed term or you conclude a new contract (with a new initial term) with us. In case of an indefinite term after the end of your applicable initial term, you may cancel your Paid Services with a notice period of at least 24 hours to the end of each subscription month.<br>
10.3. For technical and legal reasons, contractual relationships related to the use of Paid Services that were originally entered into via the Apple App Store or the Google Play Store may need to be terminated via the respective app stores or in the app (e.g. using a feature provided by the respective app store). In such cases, the respective app store provider may act as a reseller of the Paid Services. Their respective terms and conditions may apply.<br>
10.4. The statutory right of both contracting parties to terminate the contract for good cause remains unaffected. Good cause for extraordinary termination of the contract is, for example, deemed to exist if the continuation of the contractual relationship until the end of the normal period of notice is unreasonable, given all circumstances of the individual case and the interests of the user. Good causes for us to exercise this right of termination include, in particular, if you breach applicable law, obligations under these Terms, or obligations under your contract with the Apple App Store or Google Play Store (or if your actions would cause us to breach our contracts with the Apple App Store or Google Play Store).<br><br>

<b>11. Other provisions</b><br>
11.1. We endeavour to ensure that our App operates without disruption and is available to the greatest extent possible, but we point out that complete and uninterrupted availability is not technically feasible. We therefore do not guarantee disruption-free operation or a specific level of availability. In particular, we may restrict access without providing reasons – in whole or in part, temporarily or permanently. In addition, no claims shall exist regarding the maintenance of individual functionalities of our App. We are entitled at any time to change or remove content, services and functionalities that are provided within the app and to make new content, services and functionalities available or to discontinue the App entirely; this includes paywalling all or certain services that were previously free of charge, as well as their partial or complete discontinuation.<br>
11.2. If individual provisions within these Terms are or become invalid or unenforceable, the validity of the remaining provisions shall not be affected. Any invalid or unenforceable provision shall be replaced by a valid and enforceable provision whose effects come as close as possible to the economic objective which the contracting parties had pursued with the invalid or unenforceable provision. The above provisions shall also apply in the event that the provisions prove to be incomplete.<br>
''';

const String privacyPolicyHtml = '''
<b>EFFECTIVE DATE.</b> This Data Privacy Policy Agreement (hereinafter interchangeably titled ‘USER AGREEMENT’, ‘PRIVACY POLICY AGREEMENT’ or ‘PRESENTS’ for intents of brevity) explains how M/s. Naveli India Biotech Pvt. Ltd, as a Data Fiduciary, determines the purposes and means of the lawful processing of personal data of a Data Principal in compliance with legal requirements of Digital Personal Data Protection Act, 2023 & Information Technology Act, 2000 in force within limits of India.<br><br>

<b>INTERPRETATION CLAUSE.</b> Unless repugnant to context or the subject-matter of this Agreement herein, the expressions:<br>
<b>“ACT”</b> shall mean the Information Technology Act, 2000 & the Digital Personal Data Protection Act, 2023 as in force in India;<br>
<b>“APPLICATION”</b> shall, wherever used interchangeably with the expression “MOBILE APPLICATION” be deemed to mean the mobile application introduced by Data Fiduciary for purposes of marketing the same for the benefit of its target audience;<br>
<b>“CONSENT MANAGER”</b> shall cover every Nodal Officer appointed by Data Fiduciary for purposes of acting as a single point of contact so as to redress legal grievances of a Data Principal registered on & using the mobile application of Data Fiduciary;<br>
<b>“DATA FIDUCIARY”</b> shall mean M/s. Naveli India acting in its fiduciary capacity towards the best interests of a Data Principal in all matters involving usage, purpose and means employed by Data Fiduciary to process personal data of Data Principal;<br>
<b>“DATA PRINCIPAL”</b> shall mean every user who uses or profits from the usage of the mobile application introduced into the relevant product market by Data Fiduciary for its own usage or benefit to the limited extent consistent with this Agreement;<br>
<b>“DATA PROTECTION OFFICER”</b> shall mean a Consent Manager registered with Data Protection Board of India & appointed by the Data Fiduciary for purposes of resolution of any specific legal grievances, by which Appointee herein shall be deemed to authorized to act as a single point of contact to enable the Data Principal to give, manage, review or withdraw its consent; and shall be deemed to include every Designated Data Appellate Protection Officer nominated exclusively for this purpose;<br>
<b>“PERSONAL DATA”</b> shall, in context of this Agreement, always be deemed to include data which, by itself, or in connection with other factors, identifies an individual based on, or on its relation to such data in course of usage of the Application;<br>
<b>“PERSONAL DATA BREACH”</b> shall, in context of this Agreement, include the unlawful or unauthorized processing of any personal data or accidental disclosure, acquisition, sharing, usage, alteration or destruction of; or loss of access to any personal data which compromises the confidentiality, integrity or availability of personal data belonging to Data Principal;<br>
<b>“SENSITIVE PERSONAL DATA”</b> shall, for purpose of this Agreement, include all/every personal information or data of a Data Principal which comprises of information relating to a Data Principal’s (a) password; (b) financial information or (c) physical, psychological, physiological or mental health conditions; or (b) medical records and history, or (c) biometric condition(s); or (d) email addresses, nicknames, birthdays, time zones or photographs uploaded; or (e) a combination of all/any of these.<br><br>

<b>CONSTRUCTION OF HEADINGS.</b> Headings used herein shall not be deemed to constitute an essential or integral portion of this Agreement at any point of time, nor be used in application, construction, execution, scope or validity of this Agreement.<br><br>

<b>AGE OF MAJORITY.</b> It shall be presumed that at the time of availing of the various services offered by Data Fiduciary’s Mobile Application, the Data Principal had attained majority age under the Indian Majority Act, 1875 & Indian Contract Act, 1872; and nothing herein contained shall authorize the Data Principal from raising any claims or assertions inconsistent therewith.<br><br>

<b>CONTRACTUAL COMPETENCY AND FREE CONSENT.</b> Unless otherwise proved to the contrary, it shall always be presumed in any legal proceedings arising out of application, construction, execution, performance, scope or validity of this Agreement that Data Principal was seized of full contractual competency & has given express and implied informed and unconditional consent to usage of various services constituting Data Fiduciary’s Mobile Application for all the purposes set forth therein.<br><br>

<b>CONSENT OF DATA PRINCIPAL AND UNDERTAKING BY DATA FIDUCIARY.</b> Data Fiduciary & Data Principal covenant as follows:<br>
Data Principal hereby covenants that it shall cause to download the application owned by Data Fiduciary for purposes of exclusively availing of its services & shall never cause to do any act or engage in conduct which is in violation of Indian law.<br>
Data Fiduciary hereby covenants that it shall endeavor to, at all points of time, obtain voluntary consent of Data Principal for processing of its personal data, as defined by Article (2.7) of this Agreement, and may, for purposes of making available the services on its app, access, inter alia, Data Principal’s permission list, phone gallery & related user management services.<br>
provided that nothing shall authorize Data Fiduciary from accessing Data Principal’s phone contact list for the above purpose.<br>
Nothing herein shall be deemed to affect, impair or otherwise invalidate a Data Principal’s power to review or withdraw its express or implied consent to a Data Fiduciary with respect to usage of the Mobile Application, if the same is communicated by the designated Consent Manager appointed by Data Fiduciary specifically for purposes of redressing its legal grievances.<br><br>

<b>CONSTRUCTION OF DOCUMENT.</b> This Agreement shall be constructed in its entirety at all points of time for limited purposes of ensuring consistency in execution of this Agreement; and in case any ambiguities or difficulties arise in the performance of these Presents, the same shall be harmoniously interpreted in the context of Parties’ mutual intentions and object of this Agreement without being rendered void for the want of certainty of purpose, objective or subject-matter of these Presents.<br><br>

<b>GENERAL OBLIGATIONS OF DATA FIDUCIARY.</b> Taking cognizance of its statutory obligations under Indian Contract Act, 1872; the Information Technology Act, 2000 & the Digital Personal Data Protection Act, 2023, Data Fiduciary undertakes it shall, at all points of time, be responsible for complying with all three enactments in respect of all, or any personal data of a Data Principal using its Mobile Application & processed by it, or by a Data Processor specifically designated by it for this purpose.<br>
All personal data processed by a Data Fiduciary, as defined under this Agreement, shall be updated at all points of time, notwithstanding that the same may be used for purposes of making a valid decision affecting the best interests of a Data Principal, or which is required to be disclosed to another Data Fiduciary for any lawful purposes consistent with Indian laws.<br>
All personal data of a Data Principal shall be processed and protected from all forms of hacking or unauthorized access in letter & spirit, and to the extent provided under Article (8), (9) & (14) of this Data Privacy Policy Agreement {‘AGREEMENT’}.<br><br>

<b>NON-ACCESS BY A MINOR.</b> Nothing herein contained shall authorize, nor be deemed to authorize any Minor Principal in its personal capacity as a Data Principal from entering into any e-contract with the Data Fiduciary for purposes of availing of any benefits conferred under its Mobile Application, save as, or except where represented by its legal guardian or Next Friend.<br><br>

<b>SECURING OF DATA.</b> During, and in course of usage of the application referred to in Article (2.2) of the Interpretation Clause, it is mutually understood by Data Principal & Data Fiduciary that the latter is committed towards maintaining the highest degree of transparency standards involved in securing a Data Principal’s personal data; and keeping in mind that principle, Data Fiduciary affirms it shall, at all times, take such reasonable measures as it deems necessary or expedient for purposes of protecting Data Principal’s legal rights and personal data exposed by it in course of the usage of the Mobile Application.<br><br>

<b>COLLECTION OF DATA.</b> Without prejudice to anything said, done or recorded, whether expressly or by implication, in, by or under terms of Article (5) of this Agreement, Data Fiduciary covenants, warrants and assures Data Principal herein that all data collected by the former & constituting personal data under the Information Technology (Reasonable Security Practices & Procedures and Sensitive Personal Data or Information) Rules, 2011 shall be used by Data Fiduciary solely & exclusively for the purposes of improving the Data Principal’s usage experience over the Mobile Application, as defined by Article (2.2) of this Agreement; and all such data collected by Data Fiduciary may be used thereby for purposes of increasing the safety and accuracy of the within-named Mobile Application, in addition to rendering relevant application content & product offers.<br><br>

<b>COLLECTION AND PROCESSING OF PERSONAL DATA.</b> All personal data of a Data Principal may be collected by Data Fiduciary in following ways: (a) by data voluntarily provided by Data Principal; that is to say, by registration on the Mobile Application; or (b) by automatic collection of data; that is to say, data collected by way of cookies or other similar tracking technologies.<br>
Nothing shall impair a Data Fiduciary to process data in any manner whereby such processing is (a) necessary or proper for purposes of enforcing a legal right or claim recognized under Indian law, or; (b) in interest of prevention, detection or prosecution of a crime or offence punishable by Indian law, or (c) necessary for a scheme of compromise, arrangement, reconstruction, merger or amalgamation of any company, one of which is Data Fiduciary; or (d) is otherwise required by law.<br>
Pursuant to Article (9) & (10) of this Agreement, Data Fiduciary hereby declares that it may, for lawful purposes consistent with execution of this Agreement, cause to process personal data of Data Principal registered on its Mobile Application.<br>
In particular and without prejudice to anything recorded in terms of Article (10.1) of these Presents, Data Fiduciary shall bear no liability towards Data Principal in the processing of its personal data in the following circumstances hereinafter stated:<br>
For the specified purposes for which the Data Principal has voluntarily provided its personal data to the Data Fiduciary;<br>
For the performance of legal obligations, including compliance with disclosure requirements under domestic Indian law;<br>
For the purposes of compliance with any judgement, order or decree issued under domestic laws, whether or not the same constitutes a valid claim of a contractual or civil nature under laws in force within the territorial limits of India or otherwise;<br>
Nothing herein contained shall impair, or be deemed to prevent Data Fiduciary from collecting personal information of a Data Principal relating to its (a) name; (b) address; (c) location (d) date of birth; (e) password; (f) actual place or residence; (g) residential address or any of them for purposes of prevention of any offence punishable under any laws in force within India.<br>
Nothing shall authorize Data Fiduciary from causing to capture, maintain, scan, index or use; or otherwise use any form of data mining technologies such as, but not limited exclusively to clustering or classifying for purposes of maximizing sales in a manner consistent with tone and tenor of this Agreement and without prejudice to penalty of any laws in force in India.<br>
nothing herein contained shall operate as a bar in any manner or form so as to prevent Data Fiduciary from connecting Data Principal with any third-party application services to import relevant information about its activities on the Mobile Application herein, subject nevertheless to the provisions set forth under the Information Technology Act & the DPDA, 2023.<br><br>

<b>USAGE OF INFORMATION.</b> Data Fiduciary assures Data Principal that all personal information of Data Principal, inclusive of information acquired by it under Article (6) in the course of usage of the mobile application by Data Principal shall, at all times, be used by Data Fiduciary exclusively for purposes of honoring, promoting and performing its respective contractual obligations towards Data Principal such as, but not limited exclusively to account management, identification and debugging of any errors, including syntax errors arising in the course of usage of its Mobile Application & incidental issues.<br><br>

<b>CONTROL.</b> During and for the overall time period during which Data Principal actually utilizes the Mobile Application herein, nothing herein shall prevent such Data Principal from accessing, deleting and/or modifying, rectifying or updating any of its personal data input by it into the said Mobile Application by way of an email to the Designated Data Protection Officer.<br>
Nothing under Article (12) of these Presents shall impair Data Fiduciary from causing to erase any personal data of the Data Principal from its Mobile Application to which Data Principal had previously given her prior express consent in writing hereof., subject nevertheless to compliance with provisions set forth under Article (17) of this Data Privacy Policy Agreement.<br>
Nothing shall prevent Data Principal to obtain in writing or otherwise, from Data Fiduciary, a summary of any information relating to its personal data which is the subject-matter of data processment; or access to identity of any other Data Fiduciary or Data Processors with whom its personal data, as defined by Article (2.7) of these Presents, has been shared.<br>
provided that nothing herein shall require Data Fiduciary to share any information sought by Data Principal under Article (12.1) of these Presents whereto such sharing of information sought by Data Principal is the subject-matter of any investigation.<br>
Notwithstanding anything to the contrary specified by or under Article (8) of this Agreement, Data Principal is deemed to have constructive notice of the fact that in the event any data specified by Article (8) of this Agreement is modified or erased by it on and after the date Data Principal first registers on the Mobile Application hereinbefore, the such acts of modification or erasure may substantially affect its ability to use specific features of the Mobile Application, as clarified by Article (8.2)<br>
For purposes of removal of doubts, it is clarified that the acts of modification or erasure, as set forth under Article (8.1) of this Agreement shall be deemed to cover features of our app which rely on historical data provided by you at the time of signup, such as, but not limited exclusively to Data Principal’s physical, physiological or other health conditions & medical records.<br>
It is further clarified by this Agreement that notwithstanding the fact that Data Fiduciary relies on express or implied consent of Data Principal to process its personal data, nothing shall stand in the way where Data Principal has withdrawn its consent.<br><br>

<b>TRANSFER OF PERSONAL DATA.</b> During the period for which Data Principal intends to, or actually uses the Mobile Application of Data Fiduciary for the purposes specified therein, Data Fiduciary reserves its rights to transfer all, or any personal data or information collected by it under Article (5) of this Agreement, including, but not limited to any sensitive personal data or information thereby collected to any other affiliate, body corporate, successors-in-interest or other person, whether or not situated in India to extent that such affiliate, body corporate, successors-in-interest or other entity ensures same or higher degree of data privacy and data protection as Data Fiduciary; and provided that such transfer of data or information collected by Data Fiduciary is necessary for performance of a valid contract between the Data Fiduciary & the Data Principal.<br><br>

<b>DISCLOSURE OF INFORMATION.</b> It is expressly & by implication affirmed, covenanted and acknowledged by Data Fiduciary & Data Principal that information rendered by a Data Principal to Data Fiduciary constitutes its own personal information.<br>
Notwithstanding anything to the contrary stated hereinbefore, Data Fiduciary expressly covenants, warrants and assures Data Principal that it shall not, without prior consent of Data Principal, cause to disclose any personal data of Data Principal thereby collected in course of usage of Data Fiduciary’s Mobile Application to any other third-party or entity, or other intermediary save as, or except where such disclosure is required to be made pursuant to any decree, order, judgement or other finding rendered by any Court of Justice or other regulatory authorities in any legal proceedings initiated before it.<br><br>

<b>REASONABLE SECURITY PRACTICES AND PROCEDURES.</b> As a Data Fiduciary, we at M/s. Naveli India do hereby acknowledge that all data of a Data Principal & collected by us pursuant to Article (6) of these Presents constitutes its personal data within meaning of the Information Technology Act & the Digital Personal Data Protection Act, 2023; and pursuant to such acknowledgement, Data Fiduciary hereby do expressly undertake that it shall, at all points of time upon publication of this Agreement, cause to observe and implement such reasonable security practices, procedures and standards, inclusive of developing a comprehensive documentation containing, inter alia, relevant information relating to such information security programs or policies containing such relevant managerial, technical, operational or physical security features as is necessary or commensurate with the protection of a Data Principal’s privacy and legal rights, or for protecting its sensitive personal data, as defined by Article (2.7) of this Agreement; and in the event of any security breach, hacking or unauthorized access of Data Principal’s information by a third-party therein by which acts of hacking, security breach or unauthorized access Data Principal’s personal information stands exposed, Data Fiduciary shall, consequent to being seized of knowledge of such incident thereby, cause to forthwith and without any acts of inordinate delay, initiate, implement and execute such security control policies and/or procedures as per its documentation for identifying & mitigating such acts herein set forth.<br><br>

<b>DATA PROCESSING RESTRICTIONS.</b> In the event that any personal data belonging to, or identifying material particulars of Data Principal is found to be inaccurate, nothing shall prevent Data Fiduciary from causing to verify and/or update the said information on its server on written request received by its Data Protection Officer from affected Data Principal to that effect.<br><br>

<b>DATA RETENTION POLICY.</b> In the event a Data Principal intends to close its account with Data Fiduciary for whatever reason, it may visit the account settings page of the Mobile App & close its account thereby. However, Data Principal is informed that upon closing the said account on the Mobile App herein, it shall not be able to access any of its personal information, or sign into the website of the Mobile App therewith. However, nothing shall impair it from opening a new account on the Mobile Application by following the instructions set forth by Data Principal on its Mobile Application at time of closure of account.<br>
In the event any account operated by Data Principal on the Data Fiduciary’s Mobile Application stands closed, nothing shall impair Data Fiduciary from retaining certain information which is associated with the Data Principal’s account for the limited purposes of record-keeping, or to otherwise prevent any form of fraudulent activities, or to collect payments owed to it by Data Principal; or to otherwise enforce terms and conditions governing usage of its Mobile Application, as legally permitted.<br><br>

<b>COOKIES.</b> Nothing herein contained shall be deemed to impair Data Principal from setting its browser to “Refuse/reject Cookies” in the event it refuses to accept any cookies on visiting Data Principal’s Mobile Application, but Data Fiduciary does not take any responsibility for non-functioning of any features on its Mobile Application as a result of such cookie rejections.<br><br>

<b>THIRD PARTY CONTENT.</b> Data Fiduciary acknowledges that certain content and/or advertisement on its Mobile Application’s services may be rendered, or otherwise provided by third-parties not affiliated to it; and such third-parties, including advertising providers, analytical tools, & audience-measurement companies or agencies may cause to collect, receive or store any data belonging to Data Principal, including data appertaining to its usage of the Data Fiduciary’s Mobile Application through use of, but not limited exclusively to cookies, web beacons and/or other technological or electronic facilities over a span of time and combine them with other web-sites not exclusively owned, controlled or operated by the Data Fiduciary.<br><br>

<b>BUSINESS TRANSFER.</b> In the event that the business of Data Fiduciary is (a) acquired, merged or amalgamated into, or with another Data Fiduciary or other entity, or; (b) caused to stand reorganized, sold or declared insolvent or bankrupt by any valid decree, order, judgement or finding of any Court of Justice, quasi-judicial or regulatory authority specifically empowered for this purpose herein, nothing herein shall impair or prejudice the Data Principal’s legal rights in consequence.<br><br>

<b>REVISION OF POLICY.</b> This Data Privacy Policy may be revised or amended by Data Fiduciary either in whole or in part from time to time for purposes of improving its services to Data Principal, or otherwise in compliance with domestic Indian laws; and every such material change so made to the present Agreement herein shall be notified by Data Fiduciary by way of a social media update or an email duly communicated to the e-mail address of Data Principal duly registered with Data Fiduciary and associated with Data Principal’s account on the Mobile App owned by Data Principal. Further, by continuing to access or use the Mobile App herein, Data Principal expressly acknowledges to be legally bound by all assurances, terms, covenants and warranties set forth under this Agreement, including revisions or amendments made by the Data Fiduciary.<br><br>

<b>OPT-IN & OPT-OUT POLICY.</b> Nothing under the terms constituting this Data Privacy Policy shall be deemed to impair a Data Principal from receiving any text messages, emails and/or phone calls from Data Fiduciary in respect of, or in connection with usage of the Mobile App owned by Data Fiduciary. In event Data Fiduciary intent to, or otherwise wishes to stop, secede or withdraw from receiving emails, texts or phone calls, it may thereby opt out of the same by visiting the “Opt-Out Page”.<br><br>

<b>INTELLECTUAL PROPERTY RIGHTS.</b> Unless otherwise authorized in writing, nothing shall authorize a Data Principal, its agents, assignees or legal representatives intermeddling with its estate, whether directly or otherwise, from causing to use, exploit, disclose or utilize the Mobile Application, or part thereof for its personal gain, the same constituting exclusive intellectual property of the Data Fiduciary; and nothing shall authorize Data Principal from claiming any rights, titles or interests in, or accruing out of usage of the Mobile Application owned by the Data Principal at any point of time whatsoever.<br><br>

<b>FORMATION OF E-CONTRACT.</b> This Privacy Policy shall be deemed to constitute an e-contract formed by way of an electronic record; and by using the Mobile Application invented by Data Fiduciary & published on relevant operating system software, the Data Principal affirms without further protest or demur that it shall be bound by, and strictly observe this Agreement.<br><br>

<b>OBSERVANCE OF AGREEMENT.</b> Data Principal & Data Fiduciary undertake that they shall, on and after publication of this Agreement, cause to observe all assurances, covenants, representations, stipulations and warranties set forth herein and shall not deviate, nor cause to do acts, or engage in conduct which amounts to a breach of contract, or violates Indian law.<br><br>

<b>GRIEVANCE REDRESSAL MECHANISM.</b> Nothing shall cause to impair or prevent a Data Principal having a legitimate legal grievance in respect of all, breach of any of its data privacy rights, including a suspected personal data breach, or a breach of its sensitive personal data in course of using the Mobile Application belonging to Data Fiduciary from communicating an e-mail to the designated Data Protection Officer within a period of …….days next-following the incidents of breach thereby.<br>
On receipt of the said complaint referred to under Article (26) of this Agreement, the Data Protection Officer appointed by the Data Fiduciary shall make all reasonable endeavors to dispose of the complaint within a period not exceeding………days.<br>
Nothing shall be construed as implying a waiver of rights in Data Principal in filing appeal with the Designated Data Appellate Protection Officer against findings of Data Protection Officer within a span of……. days following date of the disposal order.<br><br>

<b>APPLICATION OF THE CONSTRUCTIVE NOTICE DOCTRINE.</b> Subject to provisions set forth under Article (27) of these Presents, it is hereby clarified that on and from date of publication of this Privacy Policy, every user & Affected Party thereto being a Data Principal shall be deemed to have constructive notice of such changes & shall not vest any liability in Data Fiduciary.<br><br>

<b>COMPLIANCE WITH DIRECTIVES OF DPBI ET. AL.</b> Data Fiduciary shall, at all points of time following execution of these Presents, cause to observe all directions issued by Data Protection Board of India or such other Designated Authority constituted under relevant statute law in force & applicable hereto, as are necessary for giving full effect to this document.<br><br>

<b>HEADINGS.</b> Headings shall not be deemed to constitute an essential or integral part and parcel of this Agreement at any given time, but may be used as an external aid for the purposes of reading into the intendment of this Data Privacy Policy.<br><br>

<b>INDEMNITY.</b> Data Principal undertakes to indemnify, compensate and hold harmless, at all points of time, the Data Fiduciary against all, or any breach of contract, losses or injuries arising out of performance or execution of this Agreement hereto to the extent that Data Fiduciary has acted in good faith and discharged its fiduciary obligations towards it in a lawful manner.<br><br>

<b>INCORPORATION.</b> This Agreement subsumes & incorporates by reference, all prior Agreements executed on subject-matter of this document and declares this Agreement as being the updated version reflective of legal intent of the Data Fiduciary.<br><br>

<b>SEVERABILITY.</b> If, at any point of time on or after the Effective Date, any Article constituting an essential or integral portion of this document is declared as void, unconscionable or unenforceable; or otherwise, repugnant to, or opposed to public policy or Indian law by a valid decree, order, finding or judgement of any Court of Justice in exercise of its original or appellate civil or criminal jurisdiction, nothing therein contained shall be ever deemed to impair execution of the portions thereby saved.<br><br>

<b>FORUM NON CONVENIES.</b> Each Party to this Agreement comprising Data Principal & Data Fiduciary hereby covenant, assure and warrant to one another that they do cause to waive any objections, cross-objections and related waivers as to venue of action instituted hereto; and warrant that all legal disputes arising out of the application, construction, execution, interpretation, scope or validity of this Agreement shall be ordinarily triable by the Courts of Justice at…………………………….<br>
Nothing herein contained under Article (30) shall be deemed to impair a Party to this transaction from causing to settle their respective legal disputes against each another by out-of-court settlement procedures such as mediation and/or arbitration.<br><br>

<b>AMENDMENT.</b> This Privacy Policy Agreement may be amended by Data Fiduciary at any point of time, and every such amendment thereby made shall be caused to be published on its website, as well as its Mobile Application for information of all interested parties, including Data Principal, thereby affected as a result of such amendment or modification thereof.<br><br>

<b>CONSTRUCTION OF REFERENCES.</b> Unless repugnant to the context or the subject-matter of this Agreement, references as to expressions importing words used in masculine gender shall be taken as covering their feminine counterparts; references as to terms importing words used in singular shall be deemed as covering their plural versions; and references as to either the Time or Day, or the relevant Calendar Month shall be taken as ordinarily meaning the British & not the Saka Calendar.<br><br>

<b>APPLICATION OF INDIAN CONTRACT ACT ET. AL.</b> For matters not expressly set forth herein, provisions set forth under the Indian Contract Act {IX OF 1872}; Information Technology Act {XXI OF 2000} & Commercial Courts Act {IV OF 2016} shall apply.<br><br>

<b>PUBLICATION OF POLICY.</b> This Privacy Policy may be published, in addition to the portion designated in the Mobile Application, to the website vis-à-vis Web Application, if any, on which Privacy Policy is ordinarily hosted by Data Fiduciary.<br>
''';

const String ourTeamHtmlHindi = '''
<b>हमारी टीम</b><br>
NeoW के पीछे एक समर्पित टीम है—चिकित्सा विशेषज्ञों, इनोवेटर्स और समाज-परिवर्तन के प्रति प्रतिबद्ध लोगों की, जो मिलकर महिलाओं के स्वास्थ्य को एक नई दिशा देने के लिए काम कर रहे हैं। शीर्ष संस्थानों से जुड़े डॉक्टरों और वेलनेस प्रोफेशनल्स के मार्गदर्शन में हमारा ऐप वैज्ञानिक तथ्यों पर आधारित है, जिससे हर फीचर विश्वसनीय और उपयोगी बनता है।<br><br>
हमारी तकनीकी टीम—जो IIT और IIM जैसे अग्रणी संस्थानों से आती है—NeoW के विज़न को वास्तविकता में बदलती है। वे ऐसे डिजिटल अनुभव का निर्माण करते हैं जो न केवल सुरक्षित और स्मार्ट हो, बल्कि हर महिला के लिए सहज और सरल हो। हमारी डिज़ाइन फिलॉसफी महिलाओं की ज़िंदगी को समझते हुए, एक ऐसा यूज़र इंटरफेस पेश करती है जो उपयोगकर्ता की जरूरतों के साथ कदम से कदम मिलाए।<br><br>
हम NeoW को सिर्फ एक प्रोडक्ट नहीं, बल्कि एक मिशन की तरह देखते हैं—और इसी सोच के साथ हमारा नेतृत्व प्रेरित होता है। हमारी टीम विविधता, सहयोग और साझा उद्देश्य में विश्वास रखती है। हम मानते हैं कि सबसे मजबूत समाधान तभी निकलते हैं जब भिन्न-भिन्न अनुभव और दृष्टिकोण मिलते हैं। हम एक ऐसा वातावरण बनाते हैं जहाँ विचारों को सुना जाए, बोलने की आज़ादी हो, और महिलाओं की ज़िंदगी को बेहतर बनाने का जुनून साझा किया जाए।
''';

const String missionVisionHtmlHindi = '''
<b>विजन</b><br>
हमारा सपना है एक ऐसी दुनिया का निर्माण करना, जहाँ हर महिला अपने स्वास्थ्य को लेकर न सिर्फ जागरूक हो, बल्कि आत्म-विश्वास से भरी, सशक्त और अपने निर्णयों में पूरी तरह स्वतंत्र हो। हमारा दृढ़ विश्वास है कि अच्छा स्वास्थ्य ही आत्म-विश्वास और आत्म-अभिव्यक्ति की असली नींव है। हम यह लक्ष्य लेकर चल रहे हैं कि महिलाओं के शारीरिक, मानसिक और भावनात्मक विकास को एक समग्र दृष्टिकोण से समर्थन देने वाला सबसे भरोसेमंद और सहज मंच बनें।<br><br>
हम उन अदृश्य दीवारों को तोड़ना चाहते हैं जो अब तक महिलाओं को सही जानकारी, संसाधनों और सहयोग से दूर रखती आई हैं। हम नवाचार को संवेदनशीलता के साथ जोड़कर  एक बेहतर ग्रह के निर्माण की दिशा में एक सशक्त आंदोलन चला रहे हैं।<br><br>
NeoW का मतलब है ‘New Woman’—एक ऐसी महिला जो अपनी शक्ति, अपनी पहचान और अपने स्वास्थ्य की जिम्मेदारी खुद संभालती है। यही हमारा उद्देश्य है—हर महिला को उसकी अंतर्निहित शक्ति से जोड़ना और उसे उसकी पूरी क्षमता तक पहुँचने में मदद करना।<br><br>

<b>हमारा मिशन</b><br>
NeoW का मिशन है—महिलाओं के स्वास्थ्य और वेलनेस को सरल, सुलभ और सशक्त बनाना। हमारा उद्देश्य है एक ऐसा स्मार्ट, समावेशी और सहज डिजिटल प्लेटफ़ॉर्म तैयार करना जो हर महिला को उसकी शर्तों पर अपनी सेहत संभालने का आत्मविश्वास दे।<br><br>
हम चाहते हैं कि वेलनेस हर महिला की दिनचर्या का हिस्सा बने। हम एक ऐसा मंच बना रहे हैं जो महिलाओं की ज़िंदगी, उनके अनुभव और उनकी ज़रूरतों को गहराई से समझे।<br><br>
NeoW का मानना है कि जब एक महिला अपने शरीर को समझती है और अपनी सेहत से जुड़े फैसले खुद लेती है, तभी वह सच में सशक्त होती है। हमारा प्लेटफ़ॉर्म हर पृष्ठभूमि की महिला को ध्यान में रखते हुए बनाया गया है—चाहे वह किसी गांव में हो या शहर में, छात्रा हो या मां। यह सिर्फ ऐप नहीं, एक साथी है जो हर कदम पर साथ है।<br><br>
हम महिलाओं के स्वास्थ्य पर होने वाली बातचीत को सामान्य बनाना चाहते हैं—बिना शर्म, बिना झिझक। कहानियों, संवाद और सामूहिक ज्ञान के ज़रिए हम एक ऐसा स्पेस बना रहे हैं जहाँ महिलाएं न सिर्फ खुद को स्वीकारें, बल्कि खुलकर बोल सकें, सीख सकें और एक-दूसरे से जुड़ सकें। NeoW में, वेलनेस कोई ट्रेंड नहीं—बल्कि एक सोच है, एक जीवनशैली है जिसे अपनाना हर महिला का अधिकार है।
''';
