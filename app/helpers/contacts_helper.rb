module ContactsHelper
  NOTIFY_STATE_BUTTONS = [{
                        :text => "never",
                        :icon => "ban-circle",
                        :value => "never"
                    },{
                        :text => "#mention",
                        :icon => "comment",
                        :value => "only_mention"
                    },{
                        :text => "6 hours",
                        :icon => "time",
                        :value => "6_hours"
                    },{
                        :text => "always",
                        :icon => "heart",
                        :value => "always"
                    }]
end
