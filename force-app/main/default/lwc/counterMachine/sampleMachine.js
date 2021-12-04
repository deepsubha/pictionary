export const mainMachine = () =>{
    const{Machine, assign, send} = XState;

    const increment = context => context.count + 1;
    const decrement = context => context.count - 1;

    return Machine({
            initial: 'active',
            context: {
              count: 0
            },
            states: {
              active: {
                on: {
                  INC: { actions: assign({ count: increment }) },
                  DEC: { actions: assign({ count: decrement }) }
                }
              }
            }
    })
}