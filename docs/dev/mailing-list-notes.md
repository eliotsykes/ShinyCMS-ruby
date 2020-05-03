# ShinyCMS: dev notes

## Mailing Lists ( / Discussion Groups / Forums )

### (Warning! MASSIVE creature feep occurring here!)

Things which aren't optional:  
* Double opt-in subscriptions are a basic human right ;)
* Instantly-effective unsubscribe links and headers in all list emails

Lists / Groups:  
* Enabled (emails will be delivered): yes/no
* List details page
  * Hidden: yes/no
  * Publicised (listed on hub page of some sort): yes/no
* Open for subscriptions: yes/no / see 'List subscriptions' below
* List archives (web view of previous posts to a list)
  * Provides 'view this email in your browser' functionality
  * Viewable by: anybody / subscribers / admins / nobody

List categories:  
* e.g. Announcements/Promo/Discussion/etc
* Partly for display purposes, partly for potential ACL stuff (see 'Admins')

List subscriptions:  
* Can ask to subscribe: anybody / registered website users / nobody
* Subscriptions require approval: yes/no
  * Subscriptions can be approved by: any subscriber / established subscribers /
    N+/N%+ subscribers / registered users / admins only
* Subscribers can be removed by: [ see previous list ]
* When somebody unsubscribes by any interface other than the 'manage all subs'
  page, we should include details of any other lists they are still subscribed
  to in the unsub confirmation email, and give them both the 'manage your
  subscriptions' link and also a one-click 'unsubscribe from everything' link
  (if they're leaving, they're leaving - making it harder for them is pointless)

List posts:  
* Can post to list: any subscriber / subscribers over X duration / subscribers
  over N previous posts / admins only
Moderation:  
* Posts to list require approval if they are from: anybody / unregistered
  users / new subscribers (<N posts / <X duration) / non-admins
* Posts to list can be approved by: anybody (except the original poster) /
  established subscribers / the collective vote of >N or >N% subscribers /
  registered users / admins only

Tracking (marketing?) and Engagement (list quality/sender reputation):  
* Opens are tracked: yes/no
 * Is it possible to filter out 'opens' by spam-scanning software (etc) that
   follows links to tracking pixels? Look at user-agents maybe?
* Clicks are tracked: yes/no
  * Track all the details of a click (probably for marketing) or just the fact
    that 'a click happened' (enough for engagement): detail/no detail
  * If opens and/or clicks are tracked, use them to disable emails to
    potentially-unengaged people after X duration / N emails: yes/no
    * Ask people before disabling emails to them: yes/no
* If people don't engage with emails OR web UI, disable their subscription
  entirely? (Do I want the word 'subscription' here or 'membership'- I'm back
  to wondering whether 'lists' and 'groups' are the same thing, or should be)


### Per subscriber per list config

* Receive emails sent to list: yes/no
  * Receive emails in digest format (daily/weekly?)  yes/no


## 'Admins'

(This is a near-fractal timesink of potential granularity and configurability -
it will definitely need its own ACL system/subsystem eventually.)

e.g.  
* A list/group can have: owner(s?) / admins / moderators
  * owners can create/remove admins
  * admins can delete list?
* Categories can have: ditto, and:
  * owners can edit category, create/remove admins
  * admins can create/delete lists
* The whole system has: same again? plus:
  * owners can create categories
  * etc


## Enhancements for later (because this list isn't long enough already)

* Web UI
  * 'Forum style' web interface that can be used to read and post to list too
  * Extension of 'view archives' above, or replacement for it?
* Once the system has payment handlers implemented: pay to subscribe
* Autoresponders
  * 'Timed series' autoresponders
    * (Combine with 'pay to subscribe' to enable selling 'six week course in X')
