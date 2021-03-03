import collective from './collective';
import giftcard from './giftcard';
import host from './host';
import manual from './manual';
import prepaid from './prepaid';
import test from './test';

/** Process orders from Open Collective payment method types */
async function processOrder(order) {
  switch (order.paymentMethod.type) {
    case 'prepaid':
      return prepaid.processOrder(order);
    case 'giftcard':
      return giftcard.processOrder(order);
    case 'manual':
      return manual.processOrder(order);
    case 'host':
      return host.processOrder(order);
    case 'test':
      return test.processOrder(order);
    case 'collective': // Fall through
    default:
      return collective.processOrder(order);
  }
}

/* API expected from a Payment Method provider */
export default {
  // payment method types
  // like cc, btc, prepaid, etc.
  types: {
    default: collective,
    collective,
    host,
    manual,
    prepaid,
    test,
    giftcard,
  },
  processOrder,
};
