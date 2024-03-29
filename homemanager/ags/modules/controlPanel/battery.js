const Battery = await Service.import("battery");

export const BatteryWidget = () =>
  Widget.Box({
    className: "battery",
    setup: (self) => {
      Utils.timeout(1, () => {
        self.css = `min-height: ${self.get_allocation().width - 9}px`;
      });
    },
    child: Widget.Overlay({
      child: Widget.Label({
        className: "batIcon",
        hexpand: true,
        setup: (self) => {
          self.hook(Battery, (self) => {
            const icons = [
              ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"],
              ["󰢟", "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"],
            ];

            self.label =
              icons[Battery.charging ? 1 : 0][
                Math.floor(Battery.percent / 10)
              ].toString();

            if (Battery.percent <= 15 && Battery.charging === false) {
              self.toggleClassName("low", true);
            } else {
              self.toggleClassName("low", false);
            }
          });
        },
      }),
      overlays: [
        Widget.CircularProgress({
          className: "batPercentBar",
          startAt: 0.75,
          rounded: true,
          value: 0,
          setup: (self) => {
            self.hook(Battery, (self) => {
              self.value = Battery.percent / 100;

              if (Battery.percent <= 15 && Battery.charging === false) {
                self.toggleClassName("low", true);
              } else {
                self.toggleClassName("low", false);
              }
            });
          },
        }),
      ],
    }),
  });
